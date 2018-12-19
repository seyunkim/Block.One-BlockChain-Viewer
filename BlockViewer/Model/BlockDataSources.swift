//
//  DataSource.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/17/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import LBTAComponents

class BlockTableDataSource: Datasource {
    let sharedInstance = NetworkingService.sharedInstance
    
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [BlockHeaderCell.self]
    }
    override func cellClasses() -> [DatasourceCell.Type] {
        return [BlockTableCustomCell.self]
    }
    override func item(_ indexPath: IndexPath) -> Any? {
        return sharedInstance.blockchain[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return sharedInstance.blockchain.count
    }
    
}


