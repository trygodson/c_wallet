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
import 'package:web3dart/web3dart.dart';

class AssetTokenController extends GetxController {
  double balance = 0.0;
  bool _loading = true;
  bool get loading => _loading;
  final Web3ClientRepo web3Repo;
  var assetTokenRepo = AddTokenToAssetController(tokenRepo: Get.find());
  List<AssetModel> _assetList = [];
  List<AssetModel> get assetList => _assetList;

  AssetTokenController({required this.web3Repo});

  Future<DeployedContract> loadContract(String contractAddress) async {
    String abi = await rootBundle.loadString('assets/abi.json');

    final contract = DeployedContract(ContractAbi.fromJson(abi, 'NonaToken'),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  List<TokenModel> getTokenList() {
    return assetTokenRepo as List<TokenModel>;
  }

  getAddedToken() {
    return;
  }

  dj(EthereumAddress cred, Web3Client repoclient, TokenModel e) async {
    double? bal;
    List<dynamic> result = await query(
        'balanceOf', [cred], web3Repo.ethClient!, e.deployedAddress!);
    var data = result[0];
    // bal = bal! + double.parse(data.toString());
    // print("----> dj " + data.toString());
    _assetList.add(
      AssetModel(
          tokenBalance: data.toString(),
          tokenName: e.tokenName,
          tokenSymbol: e.tokenSymbol,
          tokenIcon: e.tokenSymbol),
    );
  }

  getBalance() async {
    // update();
    _loading = true;
    web3Repo.sn();

    _assetList = [];
    dynamic userdata = Get.find<UserController>().currentUserDoc;
    var priviteAddress = userdata['privateKey'];
    var temp = EthPrivateKey.fromHex(priviteAddress!);
    EthereumAddress cred = temp.address;
    double bal = 0;

    for (var e in assetTokenRepo.assetToken) {
      // _loading = true;3

      print('----> reacched balance');

      dj(cred, web3Repo.ethClient!, TokenModel.fromJson(e));
      // print('-----> balance' + balance.toString());

      // update();
      update();
    }
    update();
    // tokenRepo.tokenList.map((e) async {
    //   await dj(cred, web3Repo.ethClient!, e);
    // });

    _loading = false;
  }

  getTotalBalance() {}

  Future<List<dynamic>> query(String functionName, List<dynamic> args,
      Web3Client ethClient, String deployedAddress) async {
    final contract = await loadContract(deployedAddress);
    final ethFunction = contract.function(functionName);
    final res =
        ethClient.call(contract: contract, function: ethFunction, params: args);

    return res;
  }
}
