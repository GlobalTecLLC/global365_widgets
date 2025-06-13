
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/utils/toast/delight_toast_files/delight_toast.dart';


/// ToastCard widget to display decent and rich looking snackbar
class ToastCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? highlightColor;
  final Color? containerColor;
  final Color? color1;
  final Color? color2;

  final Color? shadowColor;
  final Function()? onTap;
  const ToastCard(
      {super.key,
      required this.title,
      this.subtitle,
      this.leading,
      this.color,
      this.highlightColor,
      this.shadowColor,
      this.trailing,
      this.onTap,
      this.containerColor,
      this.color1,
      this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).dialogBackgroundColor,
            border: const Border(
              bottom: BorderSide(color: Colors.white, width: 1),
              top: BorderSide(color: Colors.white, width: 1),
              right: BorderSide(color: Colors.white, width: 1),
            ),
            gradient: LinearGradient(
                colors: [
                  color1 ?? Colors.transparent,
                  color2 ?? Colors.transparent,
                  const Color(0xFFF3F7FC),
                  const Color(0xFFF3F7FC),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 0.2, 0.5, 0.8]),
            boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 6, offset: Offset.zero, color: shadowColor ?? Colors.black.withOpacity(0.05))],
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: containerColor ?? Colors.transparent,
                  ),
                  width: 5,
                ),
                 GSizeW(10),
                Padding(padding: EdgeInsets.symmetric(vertical: 16), child: leading),
                 GSizeW(10),
                Expanded(
                  child: (subtitle!.length < 50)
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GTextHeading4(title),
                               GSizeW(8),
                              Expanded(child: Text(subtitle ?? "", style: GAppStyle.style12w400())),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GTextHeading4(title),
                              Text(subtitle ?? "", style: GAppStyle.style12w400()),
                            ],
                          ),
                        ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: InkWell(
                      onTap: () {
                     
                        DelightToastBar.removeAll();
                      },
                      child: const Icon(
                        CupertinoIcons.clear,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                 GSizeW(20),
              ],
            ),
          ),
        ),

        // Positioned(
        //   top: 0,
        //   right: 40,
        //   child: CircleAvatar(
        //     backgroundColor: color,
        //     child: CircleAvatar(
        //       radius: 23,
        //       backgroundColor: highlightColor ?? Colors.transparent,
        //       child: Image.asset(
        //         'assets/imgs/usa/Global Group Logo.png',
        //         height: 30,
        //         width: 30,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
