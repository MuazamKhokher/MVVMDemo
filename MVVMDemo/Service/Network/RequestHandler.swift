//
//  RequestHandler.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation

class RequestHandler {
    
    let reachability = Reachability()!
    
    func networkResult<T: Parceable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) ->
    ((Result<Data, ErrorResult>) -> Void) {
        
        return { dataResult in
            
            DispatchQueue.global(qos: .background).async(execute: {
                switch dataResult {
                case .success(let data) :
                    ParserHelper.parse(data: data, completion: completion)
                    break
                case .failure(let error) :
                    print("Network error \(error)")
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                    break
                }
            })
            
        }
    }
}
