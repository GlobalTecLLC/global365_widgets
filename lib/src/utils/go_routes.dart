import 'package:flutter/material.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:go_router/go_router.dart';

class GNav {
  static void goNav(BuildContext context, String routeName) async {
    context.go(routeName);
  }

  static void pushNav(BuildContext context, String routeName) async {
    context.push(routeName);
  }

  static void pushAndReplaceNav(BuildContext context, String routeName) async {
    context.pushReplacement(routeName);
  }

  static void pushNavWithExtra(BuildContext context, String routeName, dynamic extraData) async {
    gLogger("within pushNavWithExtra and extraData is $extraData");
    context.push(routeName, extra: extraData);
  }

  static void pushNavWithThenFunction(
    BuildContext context,
    String routeName,
    dynamic extraData,
    Function thenFunction,
  ) async {
    context.push(routeName, extra: extraData).then((onValue) {
      // Explicitly call the callback function
      thenFunction();
    });
  }

  static void pushNavWithThenFunctionWithoutExtra(BuildContext context, String routeName, Function thenFunction) async {
    context.push(routeName).then((onValue) {
      // Explicitly call the callback function
      thenFunction();
    });
  }

  static void popNav(BuildContext context) async {
    context.pop();
  }

  static void popNavWithResponse(BuildContext context, dynamic data) async {
    context.pop(data);
  }
  static void pushReplacementNamedAfterFrame(
    BuildContext context,
    String routeName, {
    Map<String, String>? parameter,
    Map<String, dynamic>? queryParameter,
    Map<String, dynamic>? extraData,
  }) {
    if (!context.mounted) return;

    final location = GoRouter.of(context).namedLocation(
      routeName,
      pathParameters: parameter ?? const <String, String>{},
      queryParameters: (queryParameter ?? const <String, dynamic>{}).map((k, v) => MapEntry(k, v?.toString() ?? '')),
    );

    context.pushReplacement(
      location,
      extra: extraData ?? const <String, dynamic>{},
    );
  }
}
