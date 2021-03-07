import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  build(conetxt) => Text('MMK Lite');
}

class AnonAvatar extends StatelessWidget {
  @override
  build(context) => Text('Очки-Шляпа');
}

class Hpadding1 extends StatelessWidget {
  final Widget child;
  Hpadding1(this.child);
  @override
  build(context) => Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: child,
      );
}

class Hpadding2 extends StatelessWidget {
  final Widget child;
  Hpadding2(this.child);
  @override
  build(context) => Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: child,
      );
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
