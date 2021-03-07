import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MmkLiteLogo extends StatelessWidget {
  @override
  build(conetxt) => Text('MMK Lite');
}

class MmkAnonAvatar extends StatelessWidget {
  @override
  build(context) => Text('Очко-Шляпа');
}

class MmkElevatedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  MmkElevatedButton({this.child, this.onPressed});

  @override
  build(context) => Container(
        width: 200,
        child: ElevatedButton(
          child: child,
          onPressed: onPressed,
        ),
      );
}
