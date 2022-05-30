//
//  CurrencyService.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation

protocol CurrencyServiceProtocol  {
    func fetchConverter(_ completion: @escaping ((Result<Converter, ErrorResult>) -> Void))
}

final class CurrencyService : RequestHandler, CurrencyServiceProtocol {
    
    static let shared = CurrencyService()
    
    let endpoint = "https://openexchangerates.org/api/latest.json?app_id=177605c97147407da7bfa8ca7efead44&&base=USD"
    var task : URLSessionTask?
    
    func fetchConverter(_ completion: @escaping ((Result<Converter, ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchCurrencies()
        
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchCurrencies() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
