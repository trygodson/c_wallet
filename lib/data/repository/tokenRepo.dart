import 'package:wallet/models/tokenmodel.dart';

class TokenRepo {
  List<TokenModel> tokenList = [
    TokenModel(
        deployedAddress: '0xa2CFAD051eB6a320DfBfBC44B8474EA611338a7b',
        tokenName: 'Waec',
        tokenSymbol: 'WAE',
        taken: false),
    TokenModel(
        deployedAddress: '0xb751940ef73d17b459b3001bccd65c49014acd01',
        tokenName: 'Gold',
        tokenSymbol: 'GLD',
        taken: false),
    TokenModel(
        deployedAddress: '0xCFeD6633469C8FBA46e7f09798f894cf7Aca2EFB',
        tokenName: 'Comic',
        tokenSymbol: 'CMC',
        taken: false),
    TokenModel(
        deployedAddress: '0x2170ed0880ac9a755fd29b2688956bd959f933f8',
        tokenName: 'Ethereum',
        tokenSymbol: 'ETH',
        taken: false),
  ];

  List<Map<String, dynamic>> jsonList = [
    TokenModel(
            deployedAddress: '0xa2CFAD051eB6a320DfBfBC44B8474EA611338a7b',
            tokenName: 'Waec',
            tokenSymbol: 'WAE',
            taken: false)
        .toJson(),
    TokenModel(
            deployedAddress: '0xb751940ef73d17b459b3001bccd65c49014acd01',
            tokenName: 'Gold',
            tokenSymbol: 'GLD',
            taken: false)
        .toJson(),
    TokenModel(
            deployedAddress: '0xCFeD6633469C8FBA46e7f09798f894cf7Aca2EFB',
            tokenName: 'Comic',
            tokenSymbol: 'CMC',
            taken: false)
        .toJson(),
    TokenModel(
            deployedAddress: '0x2170ed0880ac9a755fd29b2688956bd959f933f8',
            tokenName: 'Ethereum',
            tokenSymbol: 'ETH',
            taken: false)
        .toJson(),
  ];
}
