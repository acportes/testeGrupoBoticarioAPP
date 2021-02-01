import 'dart:math';

import 'package:uuid/uuid.dart';


class RandomUtils{

  static String generateGUID() {
    var uuid = Uuid();
    return uuid.v1();
  }

  static int getRandomInt() {
    Random rnd;
    int min = 1;
    int max = 1000;
    rnd = new Random();
    var r = min + rnd.nextInt(max - min);
    return r;
  }
}