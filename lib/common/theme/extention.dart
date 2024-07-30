part of 'theme.dart';

extension ThemeExtenion on ThemeData {
  MyColors get myColors => MyColors();
  MyStyles get myStyles => MyStyles(myColors: myColors);
  MyIcons get myIcons => MyIcons(myColors: myColors);
}