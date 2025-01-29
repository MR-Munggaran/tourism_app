import 'package:flutter/material.dart';

enum NavigationRoute {
  homeRoute("/"),
  detailRoute("/detail");

  const NavigationRoute(this.name);
  final String name;
}
