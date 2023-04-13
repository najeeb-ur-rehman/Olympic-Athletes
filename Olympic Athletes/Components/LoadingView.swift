//
//  LoadingView.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 12/04/2023.
//

import MBProgressHUD

class LoadingView {
    
    public static func show(_ view: UIView, message: String? = nil) {
        var viewFound = false
        repeat {
           viewFound = MBProgressHUD.hide(for: view, animated: true)
        } while (viewFound)
        
        let loader = MBProgressHUD.showAdded(to: view, animated: true)
        loader.mode = .indeterminate
        loader.bezelView.backgroundColor = UIColor.black
        loader.bezelView.blurEffectStyle = .dark
        if let message = message {
            loader.label.text = message
        }
        loader.contentColor = UIColor.white
    }
    
    public static func hide(_ view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
        
    }
}
