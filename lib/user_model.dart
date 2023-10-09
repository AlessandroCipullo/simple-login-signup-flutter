import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String name;
  final String surname;
  final String uid;

  UserModel(
      {required this.email,
      required this.name,
      required this.surname,
      required this.uid});

  Map<String, dynamic> toJson() =>
      {"Email": email, "Name": name, "Surname": surname, "Uid": uid};

  static UserModel? fromSnap(DocumentSnapshot snap) {
    if (snap.data() == null) {
      UserModel? um;
      return um;
    }
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        email: snapshot['Email'],
        name: snapshot['Name'],
        surname: snapshot['Surname'],
        uid: snapshot['Uid']);
  }
}
