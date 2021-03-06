import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MmkLogo extends StatelessWidget {
  @override
  build(conetxt) => Text('MMK Lite');
}

class MmkTextField extends StatelessWidget {
  final String text;
  final String label;
  final Function(String) onChanged;
  final bool obscureText;

  MmkTextField({
    this.text = '',
    this.label,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  build(context) => TextField(
        controller: TextEditingController(text: text ?? ''),
        decoration: InputDecoration(labelText: label),
        onChanged: (v) => onChanged(v ?? ''),
        obscureText: obscureText,
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
