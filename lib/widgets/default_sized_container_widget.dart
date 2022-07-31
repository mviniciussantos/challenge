import 'package:flutter/material.dart';

class DefaultSizedContainerWidget extends StatelessWidget {
  const DefaultSizedContainerWidget({
    Key? key,
    required this.sizeContainer,
    required this.text,
  }) : super(key: key);

  final Size sizeContainer;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(text), width: sizeContainer.width);
  }
}
