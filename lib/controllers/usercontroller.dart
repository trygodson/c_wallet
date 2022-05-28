import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wallet/helpers/contractFunction.dart';
import 'package:wallet/utils/constraint.dart';

class UserController extends GetxController {
  bool loading = false;
  bool walletCreated = false;
  dynamic _currentUserDoc;
  String? balance;
  ContractFunctionController? ctfunction;
  // Rx<dynamic> get currentUserDoc => _currentUserDoc;
  dynamic get currentUserDoc => _currentUserDoc;
  getCurrentUserDoc() async {
    loading = true;
    var userInstance = firebaseAuth.currentUser;
    DocumentSnapshot<dynamic> user =
        await firestore.collection('users').doc(userInstance!.uid).get();
    _currentUserDoc = user.data();
    balance = ctfunction?.balance;
    loading = false;
    update();
  }

  void addUserDetails(privateKey, publicKey) async {
    loading = true;
    update();
    walletCreated = false;

    var userInstance = firebaseAuth.currentUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userInstance!.uid)
        .set({
          'user_name': userInstance.displayName,
          'privateKey': privateKey.toString(),
          'publicKey': publicKey.toString(),
          'wallet_created': true
        })
        .whenComplete(() => {print("executed")})
        .catchError((error) {
          print(error.toString());
        });
    loading = false;
    walletCreated = false;
    update();
  }

  // Future<dynamic> getUserDetails() async {
  //   dynamic data;
  //   var userInstance = firebaseAuth.currentUser;
  //   final DocumentReference document =
  //       FirebaseFirestore.instance.collection("users").doc(userInstance!.uid);
  //   await document.get().then<dynamic>((DocumentSnapshot snapshot) {
  //     data = snapshot.data();
  //   });
  //   return data;
  // }
}
