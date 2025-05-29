import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    
    required this.msg,
    required this.color,
    required this.txtcolor,
    required this.icon,
  });
  final String msg;
  final Color color;
  final Color txtcolor;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: kIsWeb
          ? MainAxisAlignment.start
          : !(Platform.isAndroid || Platform.isIOS)
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
      crossAxisAlignment: kIsWeb
          ? CrossAxisAlignment.end
          : !(Platform.isAndroid || Platform.isIOS)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.center,
      children: [
        if (!kIsWeb)
          if (!(Platform.isAndroid || Platform.isIOS))
           const SizedBox(
              height: 40,
            ),
        if (kIsWeb)
         const SizedBox(
            height: 40,
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: kIsWeb
                  ? Get.width / 5
                  : !(Platform.isAndroid || Platform.isIOS)
                      ? Get.width / 5
                      : Get.width / 1.3,
              color: color.withValues(alpha: 0.7),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    icon,
                    color: txtcolor,
                    size: 25,
                  ),
                const  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      msg,
                      style: TextStyle(
                          color: txtcolor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
