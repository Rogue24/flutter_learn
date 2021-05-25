import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import '../main.dart';

class JPGetxController extends GetxController with ProviderControllerMixin {
  // ignore: non_constant_identifier_names
  String get TAG => runtimeType.toString();

  JPGetxController() {
    registerEventBus();
  }

  var _subscriptionList = List<StreamSubscription>();

  void subscriptEvent<T>(void subscription(T event)) {
    _subscriptionList.add(eventBus.on<T>().listen((event) {
      subscription(event);
    }));
  }

  void unRegisterEventBus() {
    _subscriptionList.forEach((element) {
      element.cancel();
    });
    _subscriptionList.clear();
  }

  @override
  void onInit() {
    super.onInit();
    registerEventBus();
    JPrint("JPGetxController -- onInit");
  }

  @override
  void onReady() {
    super.onReady();
    JPrint("JPGetxController -- onReady");
  }

  @override
  void onClose() {
    super.onClose();
    unRegisterEventBus();
    JPrint("JPGetxController -- onClose");
  }

  void registerEventBus() {}
}

mixin ProviderControllerMixin on GetxController implements ChangeNotifier {
  var changeNotifier = ChangeNotifier();

  bool get hasListeners => changeNotifier.hasListeners;

  @override
  Disposer addListener(GetStateUpdate listener) {
    changeNotifier.addListener(listener);
    return super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    changeNotifier.removeListener(listener);
    super.removeListener(listener);
  }

  @override
  void dispose() {
    changeNotifier.dispose();
    super.dispose();
  }

  @override
  void notifyListeners() {
    changeNotifier.notifyListeners();
  }
}
