//
//  ViewController.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/17/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import UIKit
import LBTAComponents
import SnapKit

var refreshControl = UIRefreshControl()
class BlockTableViewController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let blockDataSource = BlockTableDataSource()
        datasource = blockDataSource
        
        NotificationCenter.default.addObserver(self, selector: #selector(completedDownloading), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        //visual view for navBar
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "EOS Light Logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        navigationItem.titleView = logoImageView
        self.navigationController?.navigationBar.barTintColor = UIColor(r: 249, g: 249, b: 249)
        
     
        showActivityIndicator()
        
        
        // refresh controls
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl) // not required when using UITableViewController
        
        
    }
    @objc func refresh(sender:AnyObject) {
        showActivityIndicator()
        
        let sharedInstance = NetworkingService.sharedInstance
        guard !sharedInstance.downloading else{
            return
        }
        refreshControl.beginRefreshing()
        sharedInstance.startDownloadingChain(chainNumber: 20, completion: { (blockChain, error) in
            self.datasource = BlockTableDataSource()
        })
        
    }
    @objc func completedDownloading(){
        DispatchQueue.main.async {
            refreshControl.endRefreshing()
        }
        DispatchQueue.main.sync {
            self.collectionView.reloadData()
            hideActivityIndicator()
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sharedInstance = NetworkingService.sharedInstance
        let nextVC = DetailViewController()
        nextVC.blockDetails = sharedInstance.blockchain[indexPath.item]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    
}


