//
//  Models.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/17/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import Foundation

struct Block: Codable {
    let timestamp: String
    let producer: String
    let confirmed: Int
    let previous: String
    let transactionMroot: String
    let actionMroot: String
    let scheduleVersion: Int
    let newProducers: String?
    let producerSignature: String
    let id: String
    let blockNum: Int
    let refBlockPrefix: Int
    let transactions: [TransactionObject]
    //difficult to receive transaction data, developer docs on EOS dev site return empty
    
    var rawString: String?
    
}

struct TransactionObject: Codable {
    let status: String
    let cpuUsageUs: Int
    let netUsageWords: Int
    //let trx: Dict
}


struct HeadBlock : Codable {
    let headBlockNum : Int
    let headBlockId : String
    let lastIrreversibleBlockNum : Int //Will most likely use last irr block as head since its immutable
}


