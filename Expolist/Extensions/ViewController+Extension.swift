//
//  ViewController+Extension.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    public func showIndicator(withTitle title: String,
                              description:String? = nil) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = true
        indicator.detailsLabel.text = description
        indicator.show(animated: true)
    }
    
    public func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    public func alert(message: String? = nil,
                      title: String? = "Oops",
                      style: UIAlertController.Style = .alert,
                      attributedMessage: NSAttributedString? = nil,
                      withCancel: Bool = false,
                      handler: ((UIAlertAction) -> ())? = nil) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: style )
        
        alertController.addAction (UIAlertAction(title: "OK", style: .default, handler: handler) )
        
        if withCancel {
            alertController.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        
        if let attributedText = attributedMessage {
            alertController.setValue (attributedText, forKey: "attributedMessage")
        }
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

public extension UIViewController {
    class func fromNib<T>() -> T where T: Reusable, T: UIViewController  {
        let vc = T(nibName: T.nibName, bundle: nil)
        return vc
    }
}
