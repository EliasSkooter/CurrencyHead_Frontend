// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

enum ScreenSize { Small, Normal, Large, ExtraLarge }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return ScreenSize.ExtraLarge;
  if (deviceWidth > 600) return ScreenSize.Large;
  if (deviceWidth > 300) return ScreenSize.Normal;
  return ScreenSize.Small;
}

bool isMobileDevice() {
  return !kIsWeb && (Platform.isIOS || Platform.isAndroid);
}

bool isDesktopDevice() {
  return !kIsWeb &&
      (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
}

bool isWebDevice() {
  return kIsWeb;
}

bool isAndroid() {
  return Platform.isAndroid;
}

bool isIOS() {
  return Platform.isIOS;
}

// isLargeScreen(context) returns true if screen width >= 600
// it automatically adapts to orientation
bool isLargeScreen(context) => MediaQuery.of(context).size.width >= 600;
