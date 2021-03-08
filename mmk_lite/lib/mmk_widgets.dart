import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  build(conetxt) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/mmk_logo.png'),
          Container(width: 10),
          Text('LITE', style: TextStyle(fontSize: 50, color: Colors.blue[900])),
        ],
      );
}

class AnonAvatar extends StatelessWidget {
  @override
  build(context) => Image.asset('assets/anon_avatar.png');
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

class Hr1 extends StatelessWidget {
  @override
  build(context) => Column(
        children: [
          Container(height: 3),
          Container(height: 1, color: Colors.grey[200]),
          Container(height: 2),
        ],
      );
}

class Hr2 extends StatelessWidget {
  @override
  build(context) => Column(
        children: [
          Container(height: 5),
          Container(height: 2, color: Colors.grey[300]),
          Container(height: 4),
        ],
      );
}

class MmkLookupField extends StatelessWidget {
  final String text;
  final String label;
  final Function onSelect;
  MmkLookupField({this.text = '', this.label, this.onSelect});

  @override
  build(context) {
    return Stack(children: [
      TextField(
        controller: TextEditingController(text: text),
        decoration: InputDecoration(labelText: label),
        enabled: false,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: Icon(Icons.add, size: 40),
          onPressed: onSelect,
        ),
      ),
    ]);
  }
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
