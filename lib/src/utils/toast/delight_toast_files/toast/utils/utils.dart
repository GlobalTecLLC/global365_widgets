import 'package:flutter/material.dart';
import 'package:global365_widgets/src/utils/toast/delight_toast_files/delight_toast.dart';

/// The gap between stack of cards
int gapBetweenCard = 65;

/// calculate position of old cards based on current position
double calculatePosition(List<DelightToastBar> toastBars, DelightToastBar self) {
  if (toastBars.isNotEmpty && self != toastBars.last) {
    final box = self.info.key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      return gapBetweenCard * (toastBars.length - toastBars.indexOf(self) - 1);
    }
  }
  return 0;
}

/// rescale the old cards based on its position
double calculateScaleFactor(List<DelightToastBar> toastBars, DelightToastBar current) {
  int index = toastBars.indexOf(current);
  int indexValFromLast = toastBars.length - 1 - index;
  double factor = indexValFromLast / 25;
  double res = 1.03 - factor;
  return res < 1 ? 1 : res;
}
