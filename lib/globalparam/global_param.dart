import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalParams {
  static List<Map<String, dynamic>> menus = [
    {"title": "Home", "icon": Icon(Icons.home), "route": "/home"},
    {"title": "Settings", "icon": Icon(Icons.settings), "route": "/settings"},
    { "title": "Spending", "icon": Icon(Icons.money), "route": "/spending"},
  ];

  static IconData getIcon(String iconName) {
    switch (iconName) {
      case 'looks_one':
        return Icons.home;
      case 'cloud':
        return Icons.settings;
      case 'photo':
        return Icons.money;
    // Add more cases as needed for other icons
      default:
        return Icons.error; // Default icon for unknown cases
    }
  }
}