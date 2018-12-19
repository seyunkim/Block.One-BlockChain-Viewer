//
//  File.swift
//  BlockViewer
//
//  Created by Zack Kim on 12/17/18.
//  Copyright © 2018 Zack Kim. All rights reserved.
//

import UIKit

class NetworkingService{
    let endPointUrl = "https://node1.eosphere.io/v1"
    var blockchain = [Block]()
    static let sharedInstance = NetworkingService()
    private var numberBlocksToDownload : Int?
    public var downloading : Bool = false
    
    init(){
        startDownloadingChain(chainNumber: 20) { (completedChain, error) in
            print("Chain completed downloading")
            self.blockchain = completedChain
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        
    }
    
    func startDownloadingChain(chainNumber: Int , completion: @escaping chainCompleteClosure){
        print("Chain started downloading")
        
        guard !downloading else{
            return
        }
        self.downloading = true
        self.blockchain.removeAll()
        self.numberBlocksToDownload = chainNumber
        
        self.getHeadOfChain { (head, error) in
                if let error = error {
                    print(error)
                    self.downloading = false
                    completion(self.blockchain,error)
                    return
                }
                if let head = head {
                    let headNum = String(head.lastIrreversibleBlockNum)
                    self.addBlockToChain(blockid: headNum, { (uncompletedChain, derror) in
                        self.downloading = false
                        completion(uncompletedChain, derror)
                    })
                }else{
                    self.downloading = false
                    completion(self.blockchain,error)
            }
            
            
        }
        
        
        
     
        
    }
    func addBlockToChain(blockid:String, _ completion:  @escaping chainCompleteClosure){
        
        if blockchain.count == numberBlocksToDownload {
            completion(self.blockchain, nil)
            return
        }
        
        self.getSingleBlock(blockNumOrId: blockid) { (currentBlock, error) in
            guard let currBlock = currentBlock else{
                completion(self.blockchain,error)
                return
            }
            self.blockchain.append(currBlock)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            self.addBlockToChain(blockid: currBlock.previous, completion)
        }
    }
    
    func getHeadOfChain(completion: @escaping headCompleteClosure){
        guard let url = URL(string: "\(endPointUrl)/chain/get_info") else{return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return}
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let headBlock = try decoder.decode(HeadBlock.self, from: data)
                completion(headBlock,nil)
                
            }catch {
                self.presentErrorAlert(errorMessage: error.localizedDescription)
                
            }
        }.resume()
    }
    
    
    func getSingleBlock(blockNumOrId: String, completion: @escaping blockCompleteClosure) {
        guard let url = URL(string: "\(endPointUrl)/chain/get_block") else {
            return
        }
       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        let json: [String: String] = ["block_num_or_id":blockNumOrId]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    var block = try decoder.decode(Block.self, from: data)
                    block.rawString = String(data: data, encoding: .utf8)
                    completion(block,nil)
                    

                } catch {
                    print(error)
                    self.presentErrorAlert(errorMessage: error.localizedDescription)
                    return
                }
            } else {
                completion(nil, error)
                return
            }
        }
        
        task.resume()
    }

    
}

extension NetworkingService {
    //Completion block types
    typealias chainCompleteClosure = ( _ blocks: [Block], _ error: Error?)->Void
    typealias blockCompleteClosure = ( _ blocks: Block?, _ error: Error?)->Void
    typealias headCompleteClosure = ( _ head: HeadBlock?, _ error: Error?)->Void
    
    
    private func presentErrorAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error Type:", message:
            errorMessage, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
}
