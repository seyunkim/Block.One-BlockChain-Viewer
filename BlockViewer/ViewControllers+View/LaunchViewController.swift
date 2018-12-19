//
//  LaunchViewController.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/17/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import UIKit
import SnapKit
import Shimmer

class LaunchViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "EOS Dark Logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let launchLabel : UILabel = {
        let label = UILabel()
        label.text = "EOS BlockViewer"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.font = UIFont(name: "Raleway-Medium", size: 35)
        label.textAlignment = .center
        return label
    }()
    
    let viewButton : UIButton = {
        let button = UIButton()
        button.setTitle("View Chain", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    @objc func buttonPressed(){
        let navController  = UINavigationController(rootViewController: BlockTableViewController())
        self.present(navController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shimmer = FBShimmeringView(frame: logoImageView.frame)
        view.addSubview(shimmer)
        shimmer.contentView = logoImageView
        shimmer.isShimmering = true
        
        let shimmer2 = FBShimmeringView(frame: logoImageView.frame)
        view.addSubview(shimmer2)
        shimmer2.contentView = launchLabel
        shimmer2.isShimmering = true
        
        view.backgroundColor = .black
        //view.addSubview(logoImageView)
        //view.addSubview(launchLabel)
        view.addSubview(viewButton)
        
        shimmer.snp.makeConstraints { (make) in
            make.width.height.lessThanOrEqualTo(200)
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            
        }
        shimmer2.snp.makeConstraints { (make) in
            make.width.equalTo(400)
            make.height.equalTo(150)
            make.bottom.equalTo(view.snp.bottom).inset(250)
            make.centerX.equalTo(view.snp.centerX)
            
        }
        viewButton.snp.makeConstraints { (make) in
            make.top.equalTo(launchLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
            
        }
        
        
        
    }
}
