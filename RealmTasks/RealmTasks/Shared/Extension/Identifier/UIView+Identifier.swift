//
//  UIView+Identifier.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit

//
// MARK: - Default Implementation for Identifier
extension UIView: Identifier {
    
    /// ID View
    static var identifierView: String {
        get {
            return String(describing: self)
        }
    }
    
    /// XIB
    static func xib() -> UINib? {
        return UINib(nibName: self.identifierView, bundle: nil)
    }
    
    class func instanceFromXib() -> UIView? {
        return xib()?.instantiate(withOwner: nil, options: nil).first as? UIView
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    static func loadFromNib<T: UIView>() -> T {
        let nameStr = "\(self)"
        let arrName = nameStr.split { $0 == "." }
        let nibName = arrName.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! T
    }
}
