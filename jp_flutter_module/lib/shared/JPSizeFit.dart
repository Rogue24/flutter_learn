import 'dart:ui';
import 'JPLog.dart';

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

  static void initialize() {
    if (physicalWidth > 0) return;

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
  }

  static double getRpxFor(double size) => size * rpx;
  static double getPxFor(double size) => size * px;
}