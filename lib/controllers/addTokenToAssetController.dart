import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/allTokenController.dart';
import 'package:wallet/controllers/assetcontroller.dart';
import 'package:wallet/data/repository/tokenRepo.dart';
import 'package:wallet/models/tokenmodel.dart';

class AddTokenToAssetController extends GetxController {
  List<Map<String, dynamic>> assetToken = [];
  TokenRepo tokenRepo;
  List<Map<String, dynamic>> taz = [];
  late AssetTokenController assetController;

  static AllTokenController alltokenController =
      AllTokenController(tokenRepo: Get.find());

  AddTokenToAssetController({required this.tokenRepo});

  addTokenToAssetToken(TokenModel token) {
    assetController = assetController;
    var tokens = alltokenController.allToken();

    if (!assetToken.any((element) => mapEquals(element, token.toJson()))) {
      taz.add(token.toJson());
      // print();
      tokens[tokens.indexWhere((tokens) =>
              tokens.toJson()['tokenname'] == token.toJson()['tokenname'])]
          .taken = true;
      assetController.getBalance();

      update();
    }
    // assetController.assetTokenRepo = taz;
    assetController.getBalance();
    update();
  }

  removeTokenToAssetToken(TokenModel token) {
    var tokens = alltokenController.allToken();
    // print(assetToken.asMap().containsKey(token.tokenName));

    if (assetToken.any((element) => mapEquals(element, token.toJson()))) {
      taz.removeWhere(
          (element) => element['tokenname'] == token.toJson()['tokenname']);
      // print();
      tokens[tokens.indexWhere((tokens) =>
              tokens.toJson()['tokenname'] == token.toJson()['tokenname'])]
          .taken = false;

      assetController.getBalance();
      update();
    }
    // assetController.assetTokenRepo = taz;
    assetController.getBalance();

    update();
  }
}
