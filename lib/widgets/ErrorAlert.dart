import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String content;

  ErrorAlert({
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(content),
    );
  }
}
