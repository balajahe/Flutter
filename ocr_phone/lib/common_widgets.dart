import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 11);

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

class Hline1 extends StatelessWidget {
  @override
  build(context) => Column(
        children: [
          Container(height: 3),
          Container(height: 1, color: Colors.grey[200]),
          Container(height: 2),
        ],
      );
}

class Hline2 extends StatelessWidget {
  @override
  build(context) => Column(
        children: [
          Container(height: 5),
          Container(height: 2, color: Colors.grey[300]),
          Container(height: 4),
        ],
      );
}

class Waiting extends StatelessWidget {
  @override
  build(context) => Container(
        color: Color.fromARGB(200, 60, 60, 60),
        child: Center(child: CircularProgressIndicator()),
      );
}

class ErrorScreen extends StatelessWidget {
  final dynamic error;
  ErrorScreen(this.error);
  @override
  build(context) => Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 30, left: 5),
          child: SingleChildScrollView(
            child: SelectableText(
              error.toString(),
              style: TextStyle(color: Colors.red[900]),
            ),
          ),
        ),
      );
}

class ViewField extends StatelessWidget {
  final String label;
  final String text;
  final int labelFlex;
  final int textFlex;
  ViewField({this.label, this.text, this.labelFlex = 2, this.textFlex = 3});

  @override
  build(context) => Row(
        children: [
          Expanded(flex: labelFlex, child: Text(label, style: labelStyle)),
          Expanded(flex: textFlex, child: Text(text)),
        ],
      );
}

class StatelessTextField extends StatelessWidget {
  final String text;
  final String label;
  final Function(String) onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int minLines;
  final int maxLines;
  final bool selectOnFocus;

  StatelessTextField({
    this.text,
    this.label,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.selectOnFocus = false,
  });

  @override
  build(context) {
    var ctrl =
        (controller != null) ? controller : TextEditingController(text: text);
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      onTap: selectOnFocus
          ? () => ctrl.selection =
              TextSelection(baseOffset: 0, extentOffset: ctrl.value.text.length)
          : null,
    );
  }
}

class LookupTextField extends StatelessWidget {
  final String text;
  final String label;
  final Function onSelect;

  LookupTextField({this.text = '', this.label, this.onSelect});

  @override
  build(context) => Stack(children: [
        TextField(
          controller: TextEditingController(text: text),
          decoration: InputDecoration(labelText: label),
          enabled: false,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 35,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: IconButton(
                icon: Icon(Icons.add, size: 35),
                padding: EdgeInsets.all(0),
                onPressed: onSelect,
              ),
            ),
          ),
        ),
      ]);
}

class SearchTextField extends StatelessWidget {
  final String text;
  final String hint;
  final bool autofocus;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextEditingController controller;

  SearchTextField(
      {this.text,
      this.hint,
      this.autofocus = false,
      this.onChanged,
      this.onSubmitted,
      this.controller});

  @override
  build(context) => TextField(
        controller: (controller != null)
            ? controller
            : TextEditingController(text: text),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white60),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        cursorWidth: 2,
        autofocus: autofocus,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      );
}

class Logo extends StatelessWidget {
  @override
  build(conetxt) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
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
