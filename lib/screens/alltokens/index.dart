import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/allTokenController.dart';
import 'package:wallet/widgets/all_token_item.dart';

class AllTokenScreen extends StatelessWidget {
  const AllTokenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'All Tokens',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GetBuilder<AllTokenController>(builder: (tokencontroller) {
            return Column(
              children: [
                ListView.builder(
                    itemCount: tokencontroller.allToken().length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return AllTokenItem(
                        tokenname: tokencontroller.allToken()[index].tokenName!,
                        tokensymbol:
                            tokencontroller.allToken()[index].tokenSymbol!,
                        address:
                            tokencontroller.allToken()[index].deployedAddress!,
                        taken: tokencontroller.allToken()[index].taken!,
                        key: ValueKey(tokencontroller
                            .tokenRepo.tokenList[index].tokenName),
                      );
                    }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
