import 'package:flutter/material.dart';

/// ToastCard widget to display decent and rich looking snackbar
class ToastCard extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? highlightColor;

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
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: color ?? Theme.of(context).dialogTheme.backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: Offset.zero,
                      color: shadowColor ?? Colors.black.withValues(alpha: 0.05))
                ]),
            child: Container(
              color: highlightColor ?? Colors.transparent,
              child: ListTile(
                // contentPadding: const EdgeInsets.all(7),
                leading: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: leading,
                ),
                trailing: trailing,
                subtitle: subtitle,
                title: title,
                onTap: onTap,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 40,
          child: CircleAvatar(
            backgroundColor: color,
            child: CircleAvatar(
              radius: 23,
              backgroundColor: highlightColor ?? Colors.transparent,
              child: Image.asset(
                'assets/imgs/usa/Global Group Logo.png',
                height: 30,
                width: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
