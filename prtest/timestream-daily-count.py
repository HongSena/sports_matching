from datetime import datetime, timedelta
import boto3
import requests
import json

session = boto3.Session()
query_client = session.client('timestream-query')
client = query_client
paginator = client.get_paginator('query')
today = datetime.today() + timedelta(days=-1)
daily_count = 0
send_text = ""

def run_query(query_string):
    try:
        page_iterator = paginator.paginate(QueryString=query_string)
        for page in page_iterator:
           parse_query_result(page)
    except Exception as err:
        print("Exception while running query:", err)

def parse_query_result(query_result):
    global send_text
    column_info = query_result['ColumnInfo']
    for row in query_result['Rows']:
        send_text += parse_row(column_info, row) + "\n"

def parse_row(column_info, row):
    data = row['Data']
    row_output = []
    for j in range(len(data)):
        info = column_info[j]
        datum = data[j]
        row_output.append(parse_datum(info, datum))
    return str(row_output)

def parse_datum(info, datum):
    if datum.get('NullValue', False):
        return "%s=NULL" % info['Name'],

    return datum['ScalarValue']

def run_query_with_multiple_pages():
    global send_text
    query_count = daily_count_sql()
    query_region = unique_region_sql()
    query_timestamp = unique_timestamp_sql()
    query_instancetype = qunique_instancetype_sql()
    send_text += "total count\n"
    run_query(query_count)
    send_text += "unique timestamp count\n"
    run_query(query_timestamp)
    send_text += "unique region count\n"
    run_query(query_region)
    send_text += "unique instancetype count\n"
    run_query(query_instancetype)
    send_message()

def daily_count_sql():
    return f"""SELECT count(*) FROM "spotrank-timestream"."spot-table" WHERE time between timestamp '%s-%s-%s 00:00:00' and timestamp '%s-%s-%s 23:59:59' """%(today.year,today.month,today.day,today.year,today.month,today.day)
def unique_region_sql():
    return f""" SELECT AZ, count(*) FROM "spotrank-timestream"."spot-table" 
                WHERE time between 
               timestamp '%s-%s-%s 00:00:00' and timestamp '%s-%s-%s 23:59:59' 
                group by AZ order by AZ asc """%(today.year,today.month,today.day,today.year,today.month,today.day)
def unique_timestamp_sql():
    return f""" SELECT time, count(*) FROM "spotrank-timestream"."spot-table" 
                WHERE time between 
                timestamp '%s-%s-%s 00:00:00' and timestamp '%s-%s-%s 23:59:59' 
                group by time order by time asc """%(today.year,today.month,today.day,today.year,today.month,today.day)

def qunique_instancetype_sql():
    return f""" SELECT InstanceType, count(*) FROM "spotrank-timestream"."spot-table" 
                WHERE time between 
                timestamp '%s-%s-%s 00:00:00' and timestamp '%s-%s-%s 23:59:59' 
                group by InstanceType order by InstanceType asc """%(today.year,today.month,today.day,today.year,today.month,today.day)

def send_message():
    global send_text
    url='https://hooks.slack.com/services/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'#slackurl
    msg = send_text
    data = {'text':msg}
    resp = requests.post(url=url, json=data)
    return resp

if __name__ == '__main__':
    run_query_with_multiple_pages()
    print(send_text)
# def lambda_handler(event, context):
#     run_query_with_multiple_pages()
#     return {
#         'statusCode': 200,
#         'body': json.dumps('Hello from Lambda!')
#     }

