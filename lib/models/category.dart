// ignore_for_file: dead_code

import 'package:flutter/cupertino.dart';

class Category {
  String id;
  String name;
  late Color _color;
  Duration goal;

  Color get color => _color;

  Category({
    required this.id,
    required this.name,
    required String color,
    required this.goal,
  }) {
    _color = stringToColor(color);
  }

  Color stringToColor(String s) {
    switch (s) {
      case 'red':
        return const Color(0xFFFF7676);
        break;
      case 'orange':
        return const Color(0xFFFFB576);
        break;
      case 'yellow':
        return const Color(0xFFFFFF76);
        break;
      case 'green':
        return const Color(0xFF96FF76);
        break;
      case 'cyan':
        return const Color(0xFF76FFE5);
        break;
      case 'blue':
        return const Color(0xFF76A0FF);
        break;
      case 'purple':
        return const Color(0xFFE576FF);
        break;
      case 'pink':
        return const Color(0xFFFF93D1);
        break;
      case 'gray':
        return const Color(0xFFbfbfbf);
        break;
      case 'grey':
        return const Color(0xFFbfbfbf);
        break;
      default:
        return const Color(0xFFbfbfbf);
    }
  }
}
