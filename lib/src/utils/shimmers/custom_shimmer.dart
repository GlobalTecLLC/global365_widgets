import 'package:flutter/material.dart';
import 'package:global365_widgets/src/constants/constants.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final int rowNumbers;
  final int columns;
  final double? height;
  final double? rowHeight;
  final EdgeInsets? shimmerSpacing;
  final double horizontalPadding;
  final double verticalPadding;

  const CustomShimmer({
    Key? key,
    required this.rowNumbers,
    required this.columns,
    this.height,
    this.rowHeight,
    this.shimmerSpacing,
    this.horizontalPadding = 8,
    this.verticalPadding = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: lightBackgroundColor,
      highlightColor: borderColor,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(rowNumbers, (rowIndex) {
              return buildRow(rowHeight: rowHeight, shimmerSpacing: shimmerSpacing);
            }),
          ),
        ),
      ),
    );
  }

  Widget buildRow({double? rowHeight, EdgeInsets? shimmerSpacing}) {
    return Row(
      children: List.generate(columns, (colIndex) {
        return Expanded(
          child: Container(
            margin: shimmerSpacing ?? EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            height: rowHeight ?? 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white),
          ),
        );
      }),
    );
  }
}
