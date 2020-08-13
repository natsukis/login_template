import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_template/model/user.dart';
import 'package:login_template/model/userdata.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future updateUserData(String email, String name, String lastName, String mobile, String address) async{
    return await userCollection.document(uid).setData({
      'email': email,
      'name': name,
      'lastName': lastName,
      'mobile': mobile,
      'address': address
    });
  }

  //user list from snapshot
  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return UserData(
        email: doc.data['email'] ?? '',
        name: doc.data['name'] ?? '',
        lastName: doc.data['lastName'] ?? '',
        mobile: doc.data['mobile'] ?? '',
        address: doc.data['address'] ?? '',
      );
    }).toList();
  }

  //get user stream
  Stream<List<UserData>> get allusersData{
    return userCollection.snapshots()
    .map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }

  // userdata from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
    return UserData(
      email: snapshot.data['email'],
      name: snapshot.data['name'],
      lastName: snapshot.data['lastName'],
      mobile: snapshot.data['mobile'],
      address: snapshot.data['address'],
    );
  }

}