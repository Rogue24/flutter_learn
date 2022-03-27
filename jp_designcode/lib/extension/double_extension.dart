import '../shared/JPSizeFit.dart';

extension DoubleFit on double {
  double get rpx {
    return JPSizeFit.getRpxFor(this);
  }

  double get px {
    return JPSizeFit.getPxFor(this);
  }
}