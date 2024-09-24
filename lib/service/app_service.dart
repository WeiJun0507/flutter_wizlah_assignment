import 'package:flutter/material.dart';
import 'package:wizlah_assignment/service/base_service.dart';

class AppService implements BaseService {
  static final AppService _instance = AppService._internal();

  factory AppService() => _instance;

  AppService._internal();

  // Device screen siz
  Size appScreenSize = Size.zero;
  EdgeInsets appViewPadding = EdgeInsets.zero;

  @override
  Future<void> init() async {}
}
