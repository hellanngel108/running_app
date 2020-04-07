
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String uid;
  User({this.uid});
}

class UserData{
  static const ID = 'id';
  static const NAME = 'name';
  static const EMAIL = 'name';
  static const PHONE = 'name';
  static const PASS = 'pass';

  String _id;
  String _name;
  String _email;
  String _phone;
  String _pass;

  String get pass => _pass;

  String get id => _id;

  String get name => _name;

  String get email => _email;

  String get phone => _phone;

  UserData.formSnapShot(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    _name = data[NAME];
    _email = data[EMAIL];
    _phone = data[PHONE];
  }
}