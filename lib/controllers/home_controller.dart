import 'package:challenge/models/item_list.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  TextEditingController textEditingControllerParamX = TextEditingController(
    text: '2',
  );
  TextEditingController textEditingControllerParamY =
      TextEditingController(text: '10');
  TextEditingController textEditingControllerParamZ =
      TextEditingController(text: '4');

  List<ItemList> transferList = <ItemList>[];

  String? errorMessage;

  static const String noSolutionMessageError = "No Solution";
  static const String fillBucket = "Fill bucket";

  void calc() {
    transferList.clear();
    final x = int.parse(textEditingControllerParamX.value.text);
    final y = int.parse(textEditingControllerParamY.value.text);
    final z = int.parse(textEditingControllerParamZ.value.text);
    print(x % 2);
    if ((x % 2 == 1) || (y % 2 == 1) || (z % 2 == 1)) {
      errorMessage = noSolutionMessageError;
      notifyListeners();
      return;
    }
    if (x < y) {
      if (z > y) {
        errorMessage = noSolutionMessageError;
        notifyListeners();
        return;
      } else if (z < x) {
        errorMessage = noSolutionMessageError;
        notifyListeners();
        return;
      }
      if ((z - x) < (y - z)) {
        calc1(x, z);
      } else {
        calc2(x, y, z);
      }
    } else if (x > y) {
      if (z > x) {
        errorMessage = noSolutionMessageError;
        notifyListeners();
        return;
      } else if (z < y) {
        errorMessage = noSolutionMessageError;
        notifyListeners();
        return;
      }
      if ((x - z) > (z - y)) {
        calc3(y, z);
      } else {
        calc4(x, y, z);
      }
    }
    errorMessage = null;
    transferList
        .map((ItemList e) =>
            print('${e.paramX} | ${e.paramY} | ${e.explanation}'))
        .toList();
    notifyListeners();
  }

  void calc2(int paramX, int paramY, int paramZ) {
    int tempX, tempY;
    int z = paramZ;
    String explanation;
    tempY = paramY;
    tempX = 0;

    explanation = '$fillBucket y';
    transferList.add(ItemList(tempX, tempY, explanation));
    do {
      tempY -= paramX;
      explanation = 'Transfer bucket y to bucket x';
      if (tempY == z) {
        explanation = '$explanation \n Solved';
        transferList.add(ItemList(paramX, tempY, explanation));
        continue;
      }
      transferList.add(ItemList(paramX, tempY, explanation));

      explanation = 'Dump bucket x';
      transferList.add(ItemList(0, tempY, explanation));
    } while (tempY > z);
  }

  //cenario 1
  void calc1(int paramX, int paramZ) {
    int z = paramZ;
    int tempX, tempY;
    String explanation;
    tempY = 0;
    tempX = paramX;
    do {
      explanation = '$fillBucket x';
      transferList.add(ItemList(tempX, tempY, explanation));
      tempY += tempX;
      explanation = 'Transfer bucket x to bucket y';
      if (tempY == z) {
        explanation = '$explanation \n Solved';
      }
      transferList.add(ItemList(0, tempY, explanation));
    } while (tempY < z);
  }

  //cenario 3
  void calc3(int paramY, int paramZ) {
    int z = paramZ;
    int tempX, tempY;
    String explanation;
    tempY = paramY;
    tempX = 0;
    do {
      explanation = '$fillBucket y';
      transferList.add(ItemList(tempX, tempY, explanation));
      tempX += tempY;
      explanation = 'Transfer bucket y to bucket x';
      if (tempX == z) {
        explanation = '$explanation \n Solved';
      }
      transferList.add(ItemList(0, tempX, explanation));
    } while (tempX < z);
  }

  void calc4(int paramX, int paramY, int paramZ) {
    int tempX, tempY;
    int z = paramZ;
    String explanation;
    tempY = 0;
    tempX = paramX;

    explanation = '$fillBucket x';
    transferList.add(ItemList(tempY, tempX, explanation));
    do {
      tempX -= paramY;
      explanation = 'Transfer bucket x to bucket y';
      if (tempX == z) {
        explanation = '$explanation \n Solved';
        transferList.add(ItemList(paramY, tempX, explanation));
        continue;
      }
      transferList.add(ItemList(paramY, tempX, explanation));

      explanation = 'Dump bucket y';
      transferList.add(ItemList(0, tempX, explanation));
    } while (tempX > z);
  }
}
