import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 2),
  SnackBarAction? action,
  Color? backgroundColor,
  EdgeInsetsGeometry? padding,
  TextStyle? textStyle,
  Widget? icon,
  double iconSpacing = 12.0,
  SnackBarBehavior behavior = SnackBarBehavior.fixed,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      behavior: behavior,
      duration: duration,
      action: action,
      backgroundColor: backgroundColor,
      padding: padding,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Padding(
              padding: EdgeInsets.only(right: iconSpacing),
              child: icon,
            ),
          ],
          Expanded(
            child: Text(
              message,
              style: textStyle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
