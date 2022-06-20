import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wallet/controllers/addTokenToAssetController.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/data/repository/tokenRepo.dart';
import 'package:wallet/data/repository/web3ClientRepo.dart';
import 'package:wallet/models/assetmodel.dart';
import 'package:wallet/models/tokenmodel.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:wallet/controllers/allTokenController.dart';

import 'package:web3dart/web3dart.dart';

class AssetTokenController extends GetxController {
  double balance = 0.0;
  bool _loading = true;
  bool get loading => _loading;
  final Web3ClientRepo web3Repo;
  List<AssetModel> assetTokenRepo = [];
  // List<AssetModel> _theassetList = [];
  List<AssetModel> _assetList = [];
  List<AssetModel> get assetList => _assetList;

  List<Map<String, dynamic>> assetToken = [];

  AssetTokenController({required this.web3Repo});

  static AllTokenController alltokenController =
      AllTokenController(tokenRepo: Get.find());

  Future<DeployedContract> loadContract(String contractAddress) async {
    String abi = await rootBundle.loadString('assets/abi.json');

    final contract = DeployedContract(ContractAbi.fromJson(abi, 'NonaToken'),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  List<TokenModel> getTokenList() {
    return assetTokenRepo as List<TokenModel>;
  }

  dj(List<AssetModel> tempassetList, EthereumAddress cred,
      Web3Client repoclient, TokenModel e) async {
    double? bal;
    List<dynamic> result = await query(
        'balanceOf', [cred], web3Repo.ethClient!, e.deployedAddress!);
    var data = result[0];
    // bal = bal! + double.parse(data.toString());
    // print("----> dj " + data.toString());
    assetTokenRepo.addIf(
      _assetList.every((element) => element.tokenName != e.tokenName),
      AssetModel(
        tokenBalance: data.toString(),
        tokenName: e.tokenName,
        tokenSymbol: e.tokenSymbol,
        tokenIcon: e.tokenSymbol,
      ),
    );
  }

  getBalance() async {
    // update();
    _loading = true;
    web3Repo.sn();
    List<AssetModel> tempassetList = [];
    // print('----> aseet token repo ' + assetList.toString());
    dynamic userdata = Get.find<UserController>().currentUserDoc;
    var priviteAddress = userdata['privateKey'];
    var temp = EthPrivateKey.fromHex(priviteAddress!);
    EthereumAddress cred = temp.address;
    for (var e in assetToken) {
      dj(tempassetList, cred, web3Repo.ethClient!, TokenModel.fromJson(e));

      // List<dynamic> result = await query(
      //     'balanceOf', [cred], web3Repo.ethClient!, e['deployedaddress']!);
      // var data = result[0];
      // // bal = bal! + double.parse(data.toString());
      // // print("----> dj " + data.toString());
      // tempassetList.add(
      //   AssetModel(
      //     tokenBalance: data.toString(),
      //     tokenName: e['tokenname'],
      //     tokenSymbol: e['tokensymbol'],
      //     tokenIcon: e['tokenlogo'],
      //   ),
      // );
    }
    _assetList = assetTokenRepo;

    // _assetList = tempassetList;
    _loading = false;
  }

  addTokenToAssetToken(TokenModel token) {
    var tokens = alltokenController.allToken();

    if (!assetToken.any((element) => mapEquals(element, token.toJson()))) {
      assetToken.add(token.toJson());
      // // print();
      tokens[tokens.indexWhere((tokens) =>
              tokens.toJson()['tokenname'] == token.toJson()['tokenname'])]
          .taken = true;
      // assetTokenRepo = assetToken;
      // assetTokenRepo.replaceRange(0, assetTokenRepo.length, assetToken);
    }

    getBalance();
    update();
  }

  removeTokenToAssetToken(TokenModel token) {
    var tokens = alltokenController.allToken();

    if (assetToken.any((element) => mapEquals(element, token.toJson()))) {
      assetToken
          .removeWhere((element) => element['tokenname'] == token.tokenName);

      tokens[tokens.indexWhere((tokens) =>
              tokens.toJson()['tokenname'] == token.toJson()['tokenname'])]
          .taken = false;
      // assetTokenRepo = assetToken;

      // assetTokenRepo.replaceRange(0, assetTokenRepo.length, assetToken);
    }
    getBalance();

    update();
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args,
      Web3Client ethClient, String deployedAddress) async {
    final contract = await loadContract(deployedAddress);
    final ethFunction = contract.function(functionName);
    final res =
        ethClient.call(contract: contract, function: ethFunction, params: args);

    return res;
  }
}
