class TokenModel {
  String? tokenName;
  String? deployedAddress;
  String? tokenSymbol;
  String? tokenLogo;
  bool? taken;

  TokenModel(
      {required this.tokenName,
      required this.deployedAddress,
      required this.tokenSymbol,
      required this.taken});

  Map<String, dynamic> toJson() {
    return {
      'tokenname': this.tokenName,
      'deployedaddress': this.deployedAddress,
      'tokensymbol': this.tokenSymbol,
      'tokenlogo': this.tokenLogo,
    };
  }

  TokenModel.fromJson(Map<String, dynamic> json) {
    tokenName = json['tokenname'];
    deployedAddress = json['deployedaddress'];
    tokenSymbol = json['tokensymbol'];
    tokenLogo = json['tokenlogo'];
  }
}
