import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class BuildNotFoundWithCTAWidget extends StatelessWidget {
  String description;
  String assetUrl;
  String buttonTitle;
  Function buttonFunctionHandler;

  BuildNotFoundWithCTAWidget({this.description, this.assetUrl, this.buttonTitle, this.buttonFunctionHandler});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: SvgPicture.asset(
              '$assetUrl',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$description',
                    style: PadiMallTextTheme.sz14weight500(context),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: buttonFunctionHandler,
            child: Text(
              '$buttonTitle',
              style: PadiMallTextTheme.sz14weight700White(context),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          )
        ],
      ),
    );
  }
}
