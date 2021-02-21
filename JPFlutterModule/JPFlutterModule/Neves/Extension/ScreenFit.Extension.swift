//
//  ScreenFit.Extension.swift
//  Neves
//
//  Created by aa on 2021/2/7.
//

extension Int: JPCompatible {}
extension JP where Base == Int {
    var px: CGFloat { CGFloat(base) * BasisWScale }
}

extension Float: JPCompatible {}
extension JP where Base == Float {
    var px: CGFloat { CGFloat(base) * BasisWScale }
}

extension Double: JPCompatible {}
extension JP where Base == Double {
    var px: CGFloat { CGFloat(base) * BasisWScale }
}

extension CGFloat: JPCompatible {}
extension JP where Base == CGFloat {
    var px: CGFloat { base * BasisWScale }
}

extension CGPoint: JPCompatible {}
extension JP where Base == CGPoint {
    var px: CGPoint { .init(x: base.x * BasisWScale, y: base.y * BasisWScale) }
    
    static func px(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        CGPoint(x: x * BasisWScale, y: y * BasisWScale)
    }
}

extension CGSize: JPCompatible {}
extension JP where Base == CGSize {
    var px: CGSize { .init(width: base.width * BasisWScale, height: base.height * BasisWScale) }
    
    static func px(_ w: CGFloat, _ h: CGFloat) -> CGSize {
        CGSize(width: w * BasisWScale, height: h * BasisWScale)
    }
}

extension CGRect: JPCompatible {}
extension JP where Base == CGRect {
    var px: CGRect { .init(x: base.origin.x * BasisWScale,
                           y: base.origin.y * BasisWScale,
                           width: base.width * BasisWScale,
                           height: base.height * BasisWScale) }
    
    static func px(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> CGRect {
        CGRect(x: x * BasisWScale,
               y: y * BasisWScale,
               width: w * BasisWScale,
               height: h * BasisWScale)
    }
    
    static func px(_ origin: CGPoint, _ size: CGSize) -> CGRect {
        CGRect(origin: .init(x: origin.x * BasisWScale,
                             y: origin.y * BasisWScale),
               size: .init(width: size.width * BasisWScale,
                           height: size.height * BasisWScale))
    }
}
