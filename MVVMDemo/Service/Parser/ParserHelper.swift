//
//  ParserHelper.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation

protocol Parceable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    
    static func parse<T: Parceable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        do {
            
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                
                // init final result
                // check foreach dictionary if parseable
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let newModel):
                    completion(.success(newModel))
                    break
                }
                
                
            } else {
                // not an array
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            // can't parse json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
