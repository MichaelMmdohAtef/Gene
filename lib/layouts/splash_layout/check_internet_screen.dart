import 'package:Gene/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:Gene/shared/components/components.dart';
import '../../generated/l10n.dart';

class CheckInternetScreen extends StatelessWidget {
  const CheckInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: statusBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off_sharp,size: 150,color: Colors.grey[500],),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          defaultText(text: S.of(context).failedConnection,
              color: Colors.black,
              alignment: AlignmentDirectional.center,
              boxFit: BoxFit.fitHeight,
              fontSize: 14,
              context: context),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),

          Container(
            height: MediaQuery.sizeOf(context).height * 0.0626,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  decoration: BoxDecoration(
                    color: Color(0xffFE3398),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      Phoenix.rebirth(context);
                    },
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(S.of(context).tryAgain,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: defaultWhiteColor,
                          fontFamily: "Roboto",
                          height: 1.318,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
