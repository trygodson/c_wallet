import 'package:get/get.dart';
import 'package:wallet/data/repository/tokenRepo.dart';
import 'package:wallet/models/tokenmodel.dart';

class AllTokenController extends GetxController {
  TokenRepo tokenRepo;

  AllTokenController({required this.tokenRepo});

  List<TokenModel> allToken() {
    return tokenRepo.tokenList;
  }
}
