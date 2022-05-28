import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallet/utils/constraint.dart';
import 'package:web3dart/web3dart.dart';

class ContractFunctionController extends GetxController {
  String? balance;

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');

    String contractAddress = deployedcontractAddress;

    final contract = DeployedContract(ContractAbi.fromJson(abi, 'NonaToken'),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  getBalance(EthereumAddress credentialAddress, Web3Client ethClient) async {
    List<dynamic> result =
        await query('balanceOf', [credentialAddress], ethClient);
    print('getting balance');
    var data = result[0];
    balance = data.toString();
  }

  Future<String> submit(String functionname, List<dynamic> args,
      Web3Client ethClient, String privateKey) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

    DeployedContract contract = await loadContract();

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
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final res =
        ethClient.call(contract: contract, function: ethFunction, params: args);

    return res;
  }
}
