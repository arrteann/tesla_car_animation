import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  bool isRightDoorLocked = true;
  bool isLeftDoorLocked = true;
  bool isBonnetDoorLocked = true;
  bool isTrunkDoorLocked = true;

  void toggleRightDoorLock() {
    isRightDoorLocked = !isRightDoorLocked;
    notifyListeners();
  }

  void toggleLeftDoorLock() {
    isLeftDoorLocked = !isLeftDoorLocked;
    notifyListeners();
  }

  void toggleBonnetDoorLock() {
    isBonnetDoorLocked = !isBonnetDoorLocked;
    notifyListeners();
  }

  void toggleTrunkDoorLock() {
    isTrunkDoorLocked = !isTrunkDoorLocked;
    notifyListeners();
  }
}
