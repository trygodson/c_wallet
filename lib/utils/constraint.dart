//FIREBASE CONSTRAINT
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

var firebaseAuth = FirebaseAuth.instance;
// var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
var ethClient = Web3Client;
var httpClient = Client;

//controller
// var authController = AuthController.instance;
String infruraUrl =
    'https://ropsten.infura.io/v3/4113b4cfcb874aaead699420a5dfb0a9';
// String alchemyUrl =
//     'https://eth-rinkeby.alchemyapi.io/v2/dk4gNU8G4TKHt6WkLF241fiIwmMTCIJI';
// String infruraUrl =
//     'https://kovan.infura.io/v3/4113b4cfcb874aaead699420a5dfb0a9';

// String deployedcontractAddress = '0x716d200FE2178BCe83438Ef514B818bFDD2b41b6';
//waec coin
// String deployedcontractAddress = '0xcC7b8663a0a9f5572aBd5eAF623A59e1aaB4022E';

//gold
String deployedcontractAddress = '0xB9A305B9f748595E9d37c2495f22078b322944BF';

//cmc comic
// String deployedcontractAddress = '0xf033De665baF30e1B7a922A1B3B8C2AD88B51906';
