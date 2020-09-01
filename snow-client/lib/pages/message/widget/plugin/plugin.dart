import 'package:flutter/material.dart';

abstract class Plugin {
  int getOrder();

  String getName();

  Widget getIcon();

  onClick(String conversationId);
}
