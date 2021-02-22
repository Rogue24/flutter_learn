//
//  ListViewReusable.swift
//  Neves_Example
//
//  Created by aa on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

protocol ListViewReusable {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension ListViewReusable where Self: UITableViewCell {
    static var reuseIdentifier: String { "\(self)" }
    static var nib: UINib? { Self.nib() }
}

extension ListViewReusable where Self: UICollectionViewCell {
    static var reuseIdentifier: String { "\(self)" }
    static var nib: UINib? { Self.nib() }
}

extension UITableView {
    // MARK:- Register
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) where T: ListViewReusable {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) where T: ListViewReusable {
        if let nib = T.nib {
            register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            register(viewClass, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    // MARK:- Dequeue Reusable
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ListViewReusable {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ListViewReusable {
        dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UICollectionView {
    // MARK:- Register
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) where T: ListViewReusable {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func registerSectionHeader<T: UICollectionReusableView>(_ headerClass: T.Type) where T: ListViewReusable {
        if let nib = T.nib {
            register(nib, forSupplementaryViewOfKind: Self.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
        } else {
            register(headerClass, forSupplementaryViewOfKind: Self.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func registerSectionFooter<T: UICollectionReusableView>(_ headerClass: T.Type) where T: ListViewReusable {
        if let nib = T.nib {
            register(nib, forSupplementaryViewOfKind: Self.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
        } else {
            register(headerClass, forSupplementaryViewOfKind: Self.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    // MARK:- Dequeue Reusable
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ListViewReusable {
        dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T where T: ListViewReusable {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}


