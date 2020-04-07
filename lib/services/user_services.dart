import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runningapp/models/user.dart';

class UserServices{
  String collection = "users";
  Firestore _firestore = Firestore.instance;

  final String uid;
  UserServices({this.uid});
  Future<UserData> getUserData() async {
    _firestore.collection(collection).getDocuments().then((result){
      return;
    });
  }


  Future updateUserData(String name, String email, String pass, String phone) async {
    return await _firestore.collection(collection).document(uid).setData({
      'name': name,
      'email': email,
      'pass': pass,
      'phone': phone,
    });
  }
}