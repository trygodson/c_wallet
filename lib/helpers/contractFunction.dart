import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/utils/constraint.dart';
import 'package:web3dart/web3dart.dart';

class ContractFunctionController extends GetxController {
  String? balance;
  Web3Client? ethClient;
  Client? httpClient;
  bool _loading = true;
  bool get loading => _loading;

  Future<DeployedContract> loadContract(String contractAddress) async {
    String abi = await rootBundle.loadString('assets/abi.json');

    final contract = DeployedContract(
      ContractAbi.fromJson(abi, 'NonaToken'),
      EthereumAddress.fromHex(contractAddress),
    );

    return contract;
  }

  getBalance() async {
    dynamic userdata = Get.find<UserController>().currentUserDoc;
    var priviteAddress = userdata['privateKey'];
    var temp = EthPrivateKey.fromHex(priviteAddress!);
    EthereumAddress cred = temp.address;

    List<dynamic> result = await query('balanceOf', [cred], ethClient!);
    print('getting balance');
    var data = result[0];
    balance = data.toString();

    update();
    _loading = false;
  }

  Future<String> sendcoin(int amount, address) async {
    var bigamount = BigInt.from(amount);
    dynamic userdata = Get.find<UserController>().currentUserDoc;
    var priviteAddress = userdata['privateKey'];

    var response =
        submit('transfer', [address, bigamount], ethClient!, priviteAddress);
    return response;
  }

  Future<String> submit(String functionname, List<dynamic> args,
      Web3Client ethClient, String privateKey) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

    DeployedContract contract = await loadContract(deployedcontractAddress);

    final ethFunction = contract.function(functionname);
    final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );

    return result;
  }

  Future<List<dynamic>> query(
      String functionName, List<dynamic> args, Web3Client ethClient) async {
    final contract = await loadContract(deployedcontractAddress);
    final ethFunction = contract.function(functionName);
    final res =
        ethClient.call(contract: contract, function: ethFunction, params: args);

    return res;
  }
}
