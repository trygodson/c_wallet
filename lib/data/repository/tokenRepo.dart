import 'package:wallet/models/tokenmodel.dart';

class TokenRepo {
  List<TokenModel> tokenList = [
    TokenModel(
        deployedAddress: '0xcC7b8663a0a9f5572aBd5eAF623A59e1aaB4022E',
        tokenName: 'Waec',
        tokenSymbol: 'WAE',
        taken: false),
    TokenModel(
        deployedAddress: '0xB9A305B9f748595E9d37c2495f22078b322944BF',
        tokenName: 'Gold',
        tokenSymbol: 'GLD',
        taken: false),
    TokenModel(
        deployedAddress: '0xf033De665baF30e1B7a922A1B3B8C2AD88B51906',
        tokenName: 'Comic',
        tokenSymbol: 'CMC',
        taken: false),
  ];

  List<Map<String, dynamic>> jsonList = [
    TokenModel(
            deployedAddress: '0xcC7b8663a0a9f5572aBd5eAF623A59e1aaB4022E',
            tokenName: 'Waec',
            tokenSymbol: 'WAE',
            taken: false)
        .toJson(),
    TokenModel(
            deployedAddress: '0xB9A305B9f748595E9d37c2495f22078b322944BF',
            tokenName: 'Gold',
            tokenSymbol: 'GLD',
            taken: false)
        .toJson(),
    TokenModel(
            deployedAddress: '0xf033De665baF30e1B7a922A1B3B8C2AD88B51906',
            tokenName: 'Comic',
            tokenSymbol: 'CMC',
            taken: false)
        .toJson(),
  ];
}
