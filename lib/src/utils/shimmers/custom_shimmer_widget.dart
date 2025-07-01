import 'package:flutter/material.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerWidget extends StatelessWidget {
  const CustomShimmerWidget({super.key, required this.heaight, required this.width, this.isCircle = false});
  final double heaight;
  final double width;
  final bool isCircle;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: lightBackgroundColor,
      highlightColor: borderColor,
      child: Container(
        height: heaight,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isCircle ? null : BorderRadius.circular(6),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
