//switch between themes

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/theme/dark_theme.dart';
import 'package:flutter_app/pages/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier{

  //initially light mode
  ThemeData _themeData = lightMode;

  // get current theme
  ThemeData get themeData => _themeData;

  //is current theme dark mode
  bool get isDarkMode => _themeData==darkMode;

  // set theme
  set themeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }

  //toggle themes
  void toggleTheme(){
    if(_themeData==lightMode){
      themeData=darkMode;
    }
    else{
      themeData=lightMode;
    }
  }






}