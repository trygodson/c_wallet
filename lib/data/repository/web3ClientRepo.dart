import 'package:http/http.dart';
import 'package:wallet/utils/constraint.dart';
import 'package:web3dart/web3dart.dart';

class Web3ClientRepo {
  Web3Client? ethClient;
  Client? httpClient;
  sn() {
    httpClient = Client();
    ethClient = Web3Client(alchemyUrl, httpClient!);
  }
}
