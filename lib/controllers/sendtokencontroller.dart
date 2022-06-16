import 'dart:math';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/data/repository/tokenRepo.dart';
import 'package:wallet/data/repository/web3ClientRepo.dart';
import 'package:wallet/helpers/contractFunction.dart';
import 'package:wallet/models/tokenmodel.dart';
import 'package:web3dart/web3dart.dart';

class SendTokenController extends GetxController {
  final TokenRepo tokenRepo;
  bool _loading = false;
  bool get loading => _loading;

  final Web3ClientRepo web3Repo;

  SendTokenController({required this.tokenRepo, required this.web3Repo});

  static ContractFunctionController contractFunctionController =
      ContractFunctionController();

  List<Map<String, dynamic>> getTokenList() {
    return tokenRepo.jsonList;
  }

  Future<String> sendcoin(
      int amount, String address, deployedContractAddress) async {
    var bigamount = BigInt.from(amount);
    DeployedContract contract =
        await contractFunctionController.loadContract(deployedContractAddress);

    dynamic userdata = Get.find<UserController>().currentUserDoc;
    var priviteAddress = userdata['privateKey'];
    var publicAddress = userdata['publicKey'];

    var response = await submit(
        'transferFrom',
        [
          EthereumAddress.fromHex(publicAddress),
          EthereumAddress.fromHex(address),
          bigamount
        ],
        web3Repo.ethClient!,
        priviteAddress,
        contract,
        deployedContractAddress);

    return response;
  }

  Future<String> submit(
      String functionname,
      List<dynamic> args,
      Web3Client ethClient,
      String privateKey,
      DeployedContract contract,
      String deployedContractAddress) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    final ethFunction = contract.function(functionname);

    //transaction
    var transaction = Transaction.callContract(
      contract: contract,
      function: ethFunction,
      parameters: args,
      // gasPrice: ,
      maxGas: 100000,
      gasPrice: EtherAmount.inWei(BigInt.from(0.00000022)),
      from: EthereumAddress.fromHex(deployedContractAddress),
    );
    final result = await ethClient.sendTransaction(
      credentials,
      Transaction(
        to: transaction.to,
        data: transaction.data,
        value: transaction.value,
        from: transaction.from,
        gasPrice: transaction.gasPrice,
        nonce: Random().nextInt(3000),
        maxFeePerGas: transaction.maxFeePerGas,
        maxGas: transaction.maxGas,
        maxPriorityFeePerGas: transaction.maxPriorityFeePerGas,
      ),
      // Transaction.callContract(
      //     contract: contract,
      //     function: ethFunction,
      //     parameters: args,
      //     maxGas: 1000000
      //     // from: EthereumAddress.fromHex(deployedContractAddress),
      //     ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );

    // await ethClient.signTransaction(
    //   credentials,
    //   Transaction(
    //     to: transaction.to,
    //     data: transaction.data,
    //     value: transaction.value,
    //     from: transaction.from,
    //     gasPrice: transaction.gasPrice,
    //     nonce: transaction.nonce,
    //     maxFeePerGas: transaction.maxFeePerGas,
    //     maxGas: transaction.maxGas,
    //     maxPriorityFeePerGas: transaction.maxPriorityFeePerGas,
    //   ),
    //   chainId: null,
    //   fetchChainIdFromNetworkId: true,
    // );
    return result;
  }

  sendtoken(int amount, String recipientAddress, String deployedAddress) async {
    _loading = true;
    update();
    try {
      var res = await sendcoin(amount, recipientAddress, deployedAddress);
      _loading = false;
      update();
      Get.snackbar('Successful', 'Transaction hash ---> ${res.toString()}');
    } catch (e) {
      Get.snackbar('Error', 'Error sending ---> ${e.toString()}');
      print(e.toString());
      _loading = false;
      update();
    }
  }
}
