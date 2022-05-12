import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sports_matching/utils/logger.dart';

class UserService{
  Future firestoreTest()async{
    FirebaseFirestore.instance.collection('TESTING_COLLECTION').add({'testing': 'testing string', 'number': 123123});
  }

  void firestoreReadTest(){
    FirebaseFirestore
        .instance.collection('TESTING_COLLECTION')
        .doc('G6MP5aIUPwR1cdsIFibA').get()
        .then((DocumentSnapshot<Map<String, dynamic>> value) => logger.d(value.data()));
  }
}