
import 'package:flutter/cupertino.dart';
final List<MenuItem> menuItems = [
  MenuItem(
    image: Image.asset(
      "images/3x/reading-book.png",

    ),
    label: "Learn Japanese",
  ),
  MenuItem(
    image: Image.asset(
      "images/3x/dictionary.png",

    ),
    label: "Japanese Dictionary",
  ),
  MenuItem(
    image: Image.asset(
      "images/3x/translation.png",

    ),
    label: "Translator",
  ),
  MenuItem(
    image: Image.asset(
      "images/2x/linguistics.png",

    ),
    label: "Grammar",
  ),
  MenuItem(
    image: Image.asset(
      "images/left.png",

    ),
    label: "Phrases",
  ),
  MenuItem(
    image: Image.asset(
      "imagese/dictionary.png",

    ),
    label: "",
  ),
];

class MenuItem {
  final Image image;
  final String label;
  MenuItem({required this.image, required this.label});
}