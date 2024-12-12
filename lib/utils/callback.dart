import 'package:flutter/material.dart';

callAfterBuild(callBack) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callBack();
  });
}
