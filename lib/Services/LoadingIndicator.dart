import 'package:flutter/material.dart';

class LoadingIndicator {
  static BuildContext? _loadingContext;
  static BuildContext? showLoadingIndicator(BuildContext context) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.9),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        _loadingContext = context;
        return Center(
          child: Image.asset(
            "assets/images/loading.gif",
            width: 52,
          ),
        );
      },
    );
    return null;
  }

  static void hideLoadingIndicator() {
    if (_loadingContext != null && _loadingContext!.mounted) {
      Navigator.pop(_loadingContext!);
    }

    // Navigator.pop(context);
  }
}
