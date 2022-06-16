import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallet/screens/intro/intro.dart';
import 'package:wallet/screens/root/dashboard/dashboard.dart';
import 'package:wallet/screens/signup/signup_email/signup_email.dart';
import 'package:wallet/utils/constraint.dart';

class AuthController extends GetxController {
  bool loading = false;
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _guser;

  GoogleSignInAccount get guser => _guser!;

  late Rx<User?> _user;

  Rx<User?> get user => _user;

  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    //whenever
  }

  // checkUser(){
  //   if(_user == null){
  //     Get.to(() => )
  //   }
  // }

  Future googleLogin() async {
    try {
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();
      loading = true;
      if (googleUser == null) return;
      _guser = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      try {
        await firebaseAuth.signInWithCredential(credential);
        loading = false;
        update();
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.toString());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<dynamic> signIn(String email, String password) async {
    try {
      UserCredential gb = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return gb;
    } catch (e) {
      Get.snackbar('Error Signing in', e.toString());
    }
  }

  signOut() async {
    await googleSignIn.signOut();

    await firebaseAuth.signOut();
    update();
  }
}
