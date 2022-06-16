import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/allTokenController.dart';
import 'package:wallet/controllers/assetcontroller.dart';
import 'package:wallet/data/repository/tokenRepo.dart';
import 'package:wallet/models/tokenmodel.dart';

class AddTokenToAssetController extends GetxController {
  List<Map<String, dynamic>> assetToken = [];
  TokenRepo tokenRepo;

  static AssetTokenController assetController =
      AssetTokenController(web3Repo: Get.find());

  static AllTokenController alltokenController =
      AllTokenController(tokenRepo: Get.find());

  AddTokenToAssetController({required this.tokenRepo});

  addTokenToAssetToken(TokenModel token) {
    var tokens = alltokenController.allToken();

    if (!assetToken.any((element) => mapEquals(element, token.toJson()))) {
      assetToken.add(token.toJson());
      // print();
      tokens[tokens.indexWhere((tokens) =>
              tokens.toJson()['tokenname'] == token.toJson()['tokenname'])]
          .taken = true;
      assetController.getBalance();
      update();
    }
    assetController.getBalance();

    update();
  }

  removeTokenToAssetToken(TokenModel token) {
    var tokens = alltokenController.allToken();
    // print(assetToken.asMap().containsKey(token.tokenName));

    if (assetToken.any((element) => mapEquals(element, token.toJson()))) {
      assetToken.removeWhere(
          (element) => element['tokenname'] == token.toJson()['tokenname']);
      // print();
      tokens[tokens.indexWhere((tokens) =>
              tokens.toJson()['tokenname'] == token.toJson()['tokenname'])]
          .taken = false;

      assetController.getBalance();
      update();
    }
    assetController.getBalance();

    update();
  }
}
