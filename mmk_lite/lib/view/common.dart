import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MmkLogo extends StatelessWidget {
  @override
  build(conetxt) => Text('MMK Lite');
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
