//
//  CurrencyViewModel.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation

struct CurrencyViewModel {
    
    var dataSource : GenericDataSource<CurrencyRate>?
    var service: CurrencyServiceProtocol?
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service: CurrencyServiceProtocol = CurrencyService.shared, dataSource : GenericDataSource<CurrencyRate>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchCurrencies() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchConverter { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    self.dataSource?.data.value = converter.rates
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
