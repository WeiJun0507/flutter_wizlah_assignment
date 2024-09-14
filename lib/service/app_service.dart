import 'package:flutter/material.dart';

class AppService {
  static final AppService _instance = AppService._internal();

  factory AppService() => _instance;

  AppService._internal();

  // Device screen siz
  Size appScreenSize = Size.zero;
  EdgeInsets appViewPadding = EdgeInsets.zero;

  Future<void> init() async {}
}
