import 'package:flutter/material.dart';
import 'package:global365_widgets/src/constants/constants.dart';

// ignore: must_be_immutable
class GContainerWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backColor;
  final bool isInner;
  const GContainerWrapper({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.backColor,
    this.isInner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(isInner ? 8 : 16),
      margin: margin ?? const EdgeInsets.all(0),
      decoration: ShapeDecoration(
        color: backColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(isInner ? 6 : 10),
        ),
      ),
      child: child,
    );
  }
}

// ignore: must_be_immutable
class GContainerWrapperHeader extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  const GContainerWrapperHeader({required this.child, super.key, this.padding, this.color, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 6),
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.symmetric(
      //     horizontal: 15, vertical: 13),
      decoration: ShapeDecoration(
        color: color ?? primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: child,
    );
  }
}
