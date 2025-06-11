import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';

typedef TabSelectedCallback = void Function(int index, int? id);

class GCustomTabBar extends StatefulWidget {
  final List<GTabItem?> tabs;
  final int selectedIndex;
  final TabSelectedCallback? onTabSelected1;
  final ValueChanged<int>? onTabSelected;
  final double borderRadius;
  final double? padding;
  final bool? isShowBottomBorder;

  const GCustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    this.onTabSelected1,
    this.onTabSelected,
    this.borderRadius = 150,
    this.padding,
    this.isShowBottomBorder,
  });

  @override
  State<GCustomTabBar> createState() => _GCustomTabBarState();
}

class _GCustomTabBarState extends State<GCustomTabBar> {
  final ScrollController _tabScrollCtrl = ScrollController(keepScrollOffset: true, initialScrollOffset: 10);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor, width: 1.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Scrollbar(
                controller: _tabScrollCtrl,
                thumbVisibility: true,
                // trackVisibility: true,
                thickness: 5,
                radius: const Radius.circular(3),
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child: ListView.builder(
                  controller: _tabScrollCtrl,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.tabs.length,
                  itemBuilder: (context, index) {
                    final tabItem = widget.tabs[index];
                    return (tabItem == null)
                        ? Container()
                        : InkWell(
                            onTap: widget.onTabSelected != null
                                ? () {
                                    widget.onTabSelected!(index);
                                  }
                                : null,
                            child: Container(
                              decoration: BoxDecoration(
                                color: widget.selectedIndex == index ? primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(widget.borderRadius),
                                  topRight: Radius.circular(widget.borderRadius),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(bottom: 2),
                                padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: widget.selectedIndex == index ? lightBackgroundColor : whiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(widget.selectedIndex == index ? 8.0 : 0.0),
                                    topRight: Radius.circular(widget.selectedIndex == index ? 8.0 : 0.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      tabItem!.label,
                                      style: GAppStyle.style12w600(
                                        color: widget.selectedIndex == index ? primaryColor : bodyText,
                                      ),
                                    ),
                                    if (tabItem.svgPath != null)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: SvgPicture.asset(tabItem.svgPath!, height: 16, width: 16),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),

            // if (widget.isShowBottomBorder ?? true)

            //   Expanded(
            //     child: Container(
            //       decoration: const BoxDecoration(
            //         border: Border(
            //           bottom: BorderSide(
            //             color: borderColor,
            //             width: 2.0,
            //           ),
            //         ),
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}

class GTabItem {
  final String label;
  final String? svgPath;

  GTabItem({required this.label, this.svgPath});
}
