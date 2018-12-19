//
//  CustomCell.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/17/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import LBTAComponents
import UIKit



class BlockHeaderCell : DatasourceCell {
    let headerLabel : UILabel = {
        let label = UILabel()
        label.text = "Current EOS Blocks"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    override func setupViews() {
        super.setupViews()
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor.lightGray
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(15)
            make.height.equalTo(80)
            make.width.equalToSuperview()
            
        }
    }
}
class BlockTableCustomCell : DatasourceCell {
    override var datasourceItem: Any?{
        didSet{
            guard let block = datasourceItem as? Block else{return}
            blockNumLabel.text =  "Block # \(block.blockNum)"
            producerLabel.text = "Producer: \(block.producer)"
            timeStampLabel.text = "Timestamp: \(block.timestamp)"
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        }

    }
    
    let blockNumLabel : UILabel = {
        let label = UILabel()
        label.text =  "Block #"
        label.font = UIFont(name: "Raleway-Medium", size: 20)
        return label
    }()
    let producerLabel : UILabel = {
        let label = UILabel()
        label.text =  "Producer: "
        label.font = UIFont(name: "Raleway-Medium", size: 20)
        return label
    }()
    let timeStampLabel : UILabel = {
        let label = UILabel()
        label.text =  "Time: "
        label.font = UIFont(name: "Raleway-Medium", size: 20)
        return label
    }()

    override func setupViews() {
        super.setupViews()
        
        
        backgroundColor = UIColor(r: 240, g: 240, b: 240)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        //Subviews
        addSubview(blockNumLabel)
        addSubview(producerLabel)
        addSubview(timeStampLabel)
        
        //Constraints
        blockNumLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().inset(-40)
            make.left.equalTo(15)
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(30)
        }
        producerLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(30)
        }
        timeStampLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().inset(40)
            make.left.equalTo(15)
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(30)
        }
    }
    
}
