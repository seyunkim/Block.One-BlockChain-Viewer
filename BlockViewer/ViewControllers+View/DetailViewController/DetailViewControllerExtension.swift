//
//  DetailViewControllerExtension.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/18/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import UIKit
import SnapKit

extension DetailViewController {
    //core functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Block Information"
        
        
        idLabel.text = "\(idLabel.text ?? "") \(self.blockDetails?.id ?? "")"
        producerLabel.text = "\(producerLabel.text ?? "") \(self.blockDetails?.producer ?? "")"
        producerSignatureLabel.text = "\(producerSignatureLabel.text ?? "") \(self.blockDetails?.producerSignature ?? "")"
        if let count = self.blockDetails?.transactions.count{
        transactionLabel.text = "\(transactionLabel.text ?? "") \(String(count))"
        }
        let parsedText = self.blockDetails?.rawString
        moreInfoTextView.text = parsedText?.replacingOccurrences(of: ",", with: "\n\n")
        moreInfoTextView.font = UIFont.boldSystemFont(ofSize: 20)
        showMoreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        let y = self.navigationController?.navigationBar.frame.size.height
        let scrollView = UIScrollView(frame: CGRect(x: 0, y:y ?? 0 , width: screenWidth, height: screenHeight))
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentSize = CGSize(width: screenWidth, height: 2000)
        scrollView.backgroundColor = .white
        
        scrollView.addSubview(idLabel)
        scrollView.addSubview(producerLabel)
        scrollView.addSubview(producerSignatureLabel)
        scrollView.addSubview(transactionLabel)
        scrollView.addSubview(showMoreButton)
        scrollView.addSubview(moreInfoTextView)
        
        idLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalToSuperview().inset(-20)
            make.top.equalTo(25)
            make.height.equalTo(80)
            make.width.equalToSuperview().inset(20)
        }
        producerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalToSuperview().inset(-20)
            make.top.equalTo(idLabel.snp.bottom).offset(25)
            make.height.equalTo(80)
            make.width.equalToSuperview().inset(20)
        }
        producerSignatureLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalToSuperview().inset(-20)
            make.top.equalTo(producerLabel.snp.bottom).offset(25)
            make.height.equalTo(80)
            make.width.equalToSuperview().inset(20)
        }
        transactionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(producerSignatureLabel.snp.bottom).offset(25)
            make.height.equalTo(80)
            make.width.equalToSuperview().inset(20)
        }
        showMoreButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(transactionLabel.snp.bottom).offset(25)
            make.height.equalTo(30)
            make.width.equalToSuperview().inset(20)
        }
        moreInfoTextView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(showMoreButton.snp.bottom).offset(25)
            make.height.equalTo(600)
            make.width.equalToSuperview().inset(20)
        }
        
        
    }
    @objc func buttonTapped(){
        isChecked = !isChecked
        if isChecked {
            self.showMoreButton.setTitle("Show More", for: .normal)
            self.showMoreButton.setTitleColor(.green, for: .normal)
            self.moreInfoTextView.isHidden = true
        } else {
            self.showMoreButton.setTitle("Hide", for: .normal)
            self.showMoreButton.setTitleColor(.red, for: .normal)
            self.moreInfoTextView.isHidden = false
        }
    }
    
}
