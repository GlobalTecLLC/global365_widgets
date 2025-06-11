import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';

class GProgressDialog {
  GProgressDialog(this.context, {Key? key});
  BuildContext context;
  void show() {
    try {
      context.loaderOverlay.show(
        widgetBuilder: (progress) => Stack(
          children: [
            Container(color: Colors.black.withOpacity(0.4)),
            Center(
              child: Container(
                height: 120.0,
                width: 120.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: whiteColor.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                // child: Image.asset(
                //   "assets/gifs/loading_icon.gif",
                //   fit: BoxFit.cover,
                // ),
                child: SvgPicture.asset("assets/icons/usa/g365_dark.svg"),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error in showing loader: ${e.toString()}');
    }
  }

  void hide() {
    try {
      if (context.mounted && context.loaderOverlay.visible) {
        context.loaderOverlay.hide();
      }
    } catch (e) {
      debugPrint('Error in hiding loader: ${e.toString()}');
    }
  }
}
