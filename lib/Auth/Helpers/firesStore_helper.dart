import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsg_fire_base/Auth/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Models/register_request.dart';
import 'package:gsg_fire_base/Models/user_model.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getFireStoreStream() {
    return firebaseFirestore
        .collection('Chats')
        .orderBy('dateTime', descending: false)
        .snapshots();
  }

  addMessageToFireStore(Map map) async {
    firebaseFirestore
        .collection('Chats')
        .add({...map, 'userId': AuthHelper.authHelper.getUserId()});
  }

  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      // await firebaseFirestore.collection('Users').add(registerRequest.toMap());
      //استخمت هادي عشان اعطي الدوكيمنت اي دي اليوزر الي بالاوث وما يكون ايدي الدوكيمنت راندوم من الفاير بيز
      await firebaseFirestore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<UserModel> getUserFromFireStore(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(userId).get();
    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFireStore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }

  updateProfile(UserModel userModel) async {
    await firebaseFirestore
        .collection('Users')
        .doc(userModel.id)
        .update(userModel.toMap());
  }
}
