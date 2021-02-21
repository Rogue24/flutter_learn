import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/model/moguBanner_model.dart';

/*
 * 此处是 Provider 使用步骤的：1.创建自己需要共享的数据
 */
class JPMoguBannerViewModel with ChangeNotifier { // with：Mixin 混入
  MoguBanner _moguBanner;

  JPMoguBannerViewModel(this._moguBanner);
  // JPMoguBannerViewModel({String title, String image, String link}) : this._moguBanner = MoguBanner(title: title, image: image, link: link);

  factory JPMoguBannerViewModel.create({String title, String image, String link}) {
    return JPMoguBannerViewModel(MoguBanner(title: title, image: image, link: link));
  }

  MoguBanner get moguBanner => _moguBanner;
  set moguBanner(MoguBanner newValue) {
    _moguBanner = newValue;
    // 通知所有监听者
    notifyListeners();
  }
}