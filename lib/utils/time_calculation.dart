class TimeCalculation{
  String getTimeDiff(DateTime createdDate){
    DateTime now = DateTime.now();
    Duration timeDiff = now.difference(createdDate);
    if(timeDiff.inHours <= 1){
      return '${timeDiff.inMinutes}분 전';
    }else if(timeDiff.inHours <= 24){
      return '${timeDiff.inHours}시간 전';
    }else{
      return '${timeDiff.inDays}일 전';
    }

  }
}