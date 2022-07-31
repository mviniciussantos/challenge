import 'package:challenge/controllers/home_controller.dart';
import 'package:challenge/widgets/default_sized_container_widget.dart';
import 'package:challenge/widgets/header_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeContainer = MediaQuery.of(context).size * 0.3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Jug Challenge'),
      ),
      body: SingleChildScrollView(child:
          Consumer<HomeController>(builder: (context, controller, child) {
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              InputNumberWidget(
                  title: 'X', controller: controller.textEditingControllerParamX),
              InputNumberWidget(
                  title: 'Y', controller: controller.textEditingControllerParamY),
              InputNumberWidget(
                  title: 'Z', controller: controller.textEditingControllerParamZ),

            ],),

            ButtonConfirmWidget(onPress: controller.calc),
            Visibility(
              visible: controller.errorMessage == null,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    HeaderListWidget(sizeContainer: sizeContainer),
                    const Divider(
                      color: Colors.black,
                    ),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.transferList.length,
                      itemBuilder: (_, pos) {
                        final item = controller.transferList[pos];
                        return Padding(
                          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultSizedContainerWidget(
                                sizeContainer: sizeContainer,
                                text: item.paramX.toString(),
                              ),
                              DefaultSizedContainerWidget(
                                sizeContainer: sizeContainer,
                                text: item.paramY.toString(),
                              ),
                              Container(
                                width: sizeContainer.width,
                                child: RichText(
                                    text: TextSpan(
                                        text: item.explanation.toString(),
                                        style:
                                            DefaultTextStyle.of(context).style),
                                    overflow: TextOverflow.clip),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.grey,
                          indent: 1,
                        );
                      },
                    ),
                  ],
                ),
              ),
              replacement: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(controller.errorMessage ?? '')],
              ),
            ),
          ],
        );
      })),
    );
  }
}

class ButtonConfirmWidget extends StatelessWidget {
  const ButtonConfirmWidget({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: () => onPress(), child: const Text('Calc'))
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class InputNumberWidget extends StatelessWidget {
  const InputNumberWidget({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(title),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 40,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
