import 'package:flutter/material.dart';
import 'package:pro1/Search/search_engine.dart';

Color theme1 = const Color.fromRGBO(226, 228, 229, 1);
Color theme2 = Colors.blue[300]!;

///Dark Theme
Color background1 = const Color.fromRGBO(39, 46, 67, 1);
Color background2 = const Color.fromRGBO(22, 29, 48, 1);
Color fontColor2 = const Color.fromRGBO(40, 78, 139, 1);
Color fontColor3 = const Color.fromRGBO(22, 29, 48, 1);

///fits with both light & dark theme
Color background4 = const Color.fromRGBO(180, 180, 180, 1);
Color background3 = const Color.fromRGBO(40, 78, 139, 1);
Color background7 = const Color.fromRGBO(40, 78, 130, 1);

///Light Theme
Color background5 = const Color.fromRGBO(238, 128, 47, 1);
Color background6 = const Color.fromRGBO(255, 202, 165, 1);
Color fontColor1 = const Color.fromRGBO(180, 180, 180, 1);
Color fontColor4 = const Color.fromRGBO(238, 128, 47, 1);
Color fontColor6 = const Color.fromRGBO(255, 202, 165, 1);

///Images Theme
Color circleImageColor1 = const Color.fromRGBO(255, 202, 165, 1);
Color circleImageColor2 = const Color.fromRGBO(238, 128, 47, 1);
Color shadowColor1 = Colors.white10;
Color fillColor1 = const Color.fromRGBO(22, 29, 48, 0.66);

class Themes {
  Color shadowColor2 = Colors.white10;
  InputDecoration textFormFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: fontColor4,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  InputDecoration passwordFieldDecoration(String label, bool visible) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: fontColor4,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      suffixIcon: IconButton(
        onPressed: () => visible = !visible,
        color: background5,
        icon: visible
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off_outlined),
      ),
    );
  }

  TextStyle inputStyle() {
    return TextStyle(color: fontColor4);
  }

  BoxDecoration screenDecoration(BuildContext ctx) {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      color: Theme.of(ctx).canvasColor,
    );
  }

  BoxDecoration screenLightDecoration(BuildContext ctx) {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      color: Theme.of(ctx).canvasColor,
    );
  }

  Text title(String txt) {
    return Text(
      txt,
      style: TextStyle(
        color: fontColor4,
        fontSize: 35,
        fontWeight: FontWeight.w800,
        shadows: const [
          Shadow(
            color: Colors.black,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Text trailing(String txt) {
    return Text(
      txt,
      style: TextStyle(
        color: Colors.orange[700],
      ),
      textAlign: TextAlign.center,
    );
  }

  Text trailingChooseNode(String txt) {
    return Text(
      txt,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text textButtonStyle(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: fontColor4,
        shadows: const [
          Shadow(
            color: Colors.black,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Text linkText1(String txt) {
    return Text(
      txt,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text linkText2(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.orange[800],
      ),
    );
  }

  Text resetLink(String txt) {
    return Text(
      txt,
      style: TextStyle(
        color: Colors.orange[700],
      ),
    );
  }

  Text menuText(String txt) {
    return Text(
      txt,
      style: TextStyle(
        color: fontColor1,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

Row appLogo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'media/images/TotalControl_Logo.png',
        width: 100,
        height: 100,
      ),
      Text(
        'Total Control',
        style: TextStyle(
          color: fontColor4,
          fontWeight: FontWeight.w800,
          fontSize: 30,
        ),
      ),
    ],
  );
}

Widget searchBar(BuildContext context) {
  return IconButton(
    onPressed: () {
      showSearch(
        context: context,
        delegate: SearchEngine(),
      );
    },
    icon: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.search,
          color: fontColor1,
          size: 30,
        ),
        Text(
          'Search',
          style: TextStyle(
            color: fontColor1,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}
