import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static Future<T> pushPage<T extends Object>(
      BuildContext context, Widget page) {
    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (ctx) => page),
    );
  }

  static void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static Widget getWidget(String path) {
     return Image.asset(getImgPath(path), fit: BoxFit.cover);
  }

  static Image getBigImage(String url) {
    return Image.asset(getImgPath(url), fit: BoxFit.cover);
  }
}
