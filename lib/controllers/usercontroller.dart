import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/wallet_creation.dart';
import 'package:wallet/helpers/contractFunction.dart';
import 'package:wallet/screens/root/wallet/walletcreated/walletcreated.dart';
import 'package:wallet/utils/constraint.dart';

class UserController extends GetxController {
  bool loading = false;
  bool walletCreated = false;
  dynamic _currentUserDoc;
  String? balance;
  ContractFunctionController? ctfunction;
  static WalletAddressController walletcontroller = WalletAddressController();

  // var user = firebaseAuth.;
  // Rx<dynamic> get currentUserDoc => _currentUserDoc;
  dynamic get currentUserDoc => _currentUserDoc;
  getCurrentUserDoc() async {
    loading = true;
    var userInstance = firebaseAuth.currentUser;
    DocumentSnapshot<dynamic> user =
        await firestore.collection('users').doc(userInstance!.uid).get();
    _currentUserDoc = user.data();
    loading = false;
    balance = ctfunction?.balance;
    update();
  }

  void addUserDetails(mnemonic) async {
    loading = true;
    update();
    final privKey = await walletcontroller.getPrivateKey(mnemonic);
    final pubKey = await walletcontroller.getPublicKey(privKey);

    walletCreated = false;

    var userInstance = firebaseAuth.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userInstance!.uid)
          .set({
            'user_name': userInstance.displayName,
            'privateKey': privKey.toString(),
            'publicKey': pubKey.toString(),
            'wallet_created': true
          })
          .whenComplete(() => {print("executed")})
          .catchError((error) {
            print(error.toString());
          });
      loading = false;
      walletCreated = false;
      update();
      Get.off(() => WalletCreated(
            privkey: privKey,
            pubKey: pubKey.toString(),
          ));
    } catch (e) {
      loading = false;
      update();

      Get.snackbar('Error', 'Error generating wallet ${e.toString()}');
    }
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
