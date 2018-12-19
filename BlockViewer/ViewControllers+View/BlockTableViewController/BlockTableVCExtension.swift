//
//  BlockTableVCExtension.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/18/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import UIKit

extension BlockTableViewController {
    //basic activity indicator code
    func showActivityIndicator(){
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.showActivityIndicator()
            }
            return
        }
        let window = UIApplication.shared.keyWindow!
        let container: UIView = UIView()
        container.tag = 3105
        container.frame = window.frame
        container.center = window.center
        container.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = container.center
        loadingView.backgroundColor = UIColor(red: 68/256, green: 68/256, blue: 68/256, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.style = .whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        window.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator() {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.hideActivityIndicator()
            }
            return
        }
        let window = UIApplication.shared.keyWindow!
        for view in window.subviews {
            if view.tag == 3105 {
                let actInd = view.subviews.first?.subviews.first as? UIActivityIndicatorView
                actInd?.stopAnimating()
                view.removeFromSuperview()
                break
            }
        }
    }
}
