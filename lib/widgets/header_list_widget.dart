import 'package:flutter/material.dart';

import 'default_sized_container_widget.dart';

class HeaderListWidget extends StatelessWidget {
  const HeaderListWidget({
    Key? key,
    required this.sizeContainer,
  }) : super(key: key);

  final Size sizeContainer;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      DefaultSizedContainerWidget(
        sizeContainer: sizeContainer,
        text: 'Bucket X',
      ),
      DefaultSizedContainerWidget(
        sizeContainer: sizeContainer,
        text: 'Bucket Y',
      ),
      DefaultSizedContainerWidget(
        sizeContainer: sizeContainer,
        text: 'Explanation',
      ),
    ]);
  }
}
