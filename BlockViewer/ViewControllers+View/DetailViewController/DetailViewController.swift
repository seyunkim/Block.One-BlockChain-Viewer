//
//  DetailViewController.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/17/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import UIKit
import LBTAComponents

let sharedInstance = NetworkingService.sharedInstance
class DetailViewController: UIViewController {
    //viewdidload and other core functions in extension
    var blockDetails : Block?
    var isChecked = true
    
    let idLabel : UILabel = {
        let label = UILabel()
        label.text = "ID: "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let producerLabel : UILabel = {
        let label = UILabel()
        label.text = "Producer"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    let producerSignatureLabel : UILabel = {
        let label = UILabel()
        label.text = "Producer Signature: "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    let transactionLabel : UILabel = {
        let label = UILabel()
        label.text = "Number of Transactions : "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let showMoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("Show More", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        return button
    }()
    
    let moreInfoTextView : UITextView = {
        let textView = UITextView()
        textView.allowsEditingTextAttributes = false
        textView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        textView.layer.cornerRadius = 12
        textView.layer.masksToBounds = true
        textView.isHidden = true
        return textView
    }()
    
}


