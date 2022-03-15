import 'dart:async';
import 'dart:ui';
import 'package:jp_flutter_demo/JPLog.dart';

class JPSizeFit {
  // 缩放因子
  static double dpr = 0;

  // 物理宽度（像素）
  static double physicalWidth = 0;
  // 物理高度（像素）
  static double physicalHeight = 0;

  // 逻辑宽度
  static double screenWidth = 0;
  // 逻辑高度
  static double screenHeight = 0;

  // 安全区域 - 顶部高度
  static double safeTopMargin = 0;
  // 安全区域 - 底部高度
  static double safeBottomMargin = 0;

  // 缩放比例 - 以物理分辨率（像素）为基准
  static double rpx = 0;
  // 缩放比例 - 以逻辑分辨率为基准
  static double px = 0;

  // 是否已经初始化
  static bool _isInited = false;
  bool get isInited => _isInited;

  static void initialize(VoidCallback complete) async {
    if (_isInited) return;
    _isInited = true;

    // 此时的 window 还没有完全初始化，宽高都是0，通过 Timer.run，把【要执行的代码块】放入到<<事件队列>>的后面
    // 此时放入的将会在 build 之后才会执行（build方法本来已经放入到事件队列的了），到那时候 window 是已经初始化了
    Timer.run(() {
      if (window.physicalSize.width == 0) {
        JPrint("window还是空的");
        _isInited = false;
        return;
      }

      dpr = window.devicePixelRatio;

      physicalWidth = window.physicalSize.width;
      physicalHeight = window.physicalSize.height;

      screenWidth = physicalWidth / dpr;
      screenHeight = physicalHeight / dpr;

      safeTopMargin = window.padding.top / dpr;
      safeBottomMargin = window.padding.bottom / dpr;

      // 以 iPhone6 的尺寸为基准
      rpx = screenWidth / 750;
      px = screenWidth / 375;
      
      JPrint("缩放因子：$dpr");
      JPrint("物理分辨率：$physicalWidth - $physicalHeight");
      JPrint("逻辑分辨率：$screenWidth - $screenHeight");
      JPrint("安全区域 - 顶部边距：$safeTopMargin，底部边距：$safeBottomMargin");
      JPrint("缩放比例 - 基于物理分辨率：$rpx，基于逻辑分辨率：$px");

      complete();
    });
  }

  static double getRpxFor(double size) => size * rpx;
  static double getPxFor(double size) => size * px;
}
