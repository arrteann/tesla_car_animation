import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int selectedTab = 0;

  bool isRightDoorLocked = true;
  bool isLeftDoorLocked = true;
  bool isBonnetDoorLocked = true;
  bool isTrunkDoorLocked = true;

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

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

  // Temp
  bool isCoolSelected = true;

  void updateCoolSelectedTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }
}
