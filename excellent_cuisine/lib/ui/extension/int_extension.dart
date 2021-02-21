import '../shared/JPSizeFit.dart';

extension IntFit on int {
  double get rpx {
    return JPSizeFit.getRpxFor(this.toDouble());
  }

  double get px {
    return JPSizeFit.getPxFor(this.toDouble());
  }
}