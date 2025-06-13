import 'package:flutter/material.dart';
import 'package:global365_widgets/src/utils/toast/delight_toast_files/delight_toast.dart';
import 'package:global365_widgets/src/utils/toast/delightful_toast_card.dart';


/// mock data for testing
List demoToastBars = [
  DelightToastBar(
    autoDismiss: false,
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      title: "Hi I'm Dash, Let's have a walkthrough of Delight Toast",
    ),
  ),
  DelightToastBar(
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      title: "Delight Toast is interactive!",
    ),
  ),
  DelightToastBar(
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      title: "Toast is removable on swipe!",
    ),
  ),
  DelightToastBar(
    autoDismiss: false,
    builder: (context) => ToastCard(
      leading: const Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      trailing: IconButton(
          onPressed: () {
            DelightToastBar.removeAll();
          },
          icon: const Icon(Icons.close)),
      title: "Toast is removable on action!",
    ),
  ),
  DelightToastBar(
    autoDismiss: true,
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      title: "Toast is auto dismissable if you are lazy enough!",
    ),
  ),
  DelightToastBar(
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      subtitle: "You can add subtitle",
      title: "You can add title",
    ),
  ),
];
