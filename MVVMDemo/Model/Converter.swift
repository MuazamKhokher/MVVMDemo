//
//  Converter.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation

struct Converter {
    
    let base : String
    let timestamp : Double
    let rates : [CurrencyRate]
}

extension Converter : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Converter, ErrorResult> {
        if let base = dictionary["base"] as? String,
            let timestamp = dictionary["timestamp"] as? Double,
            let rates = dictionary["rates"] as? [String: Double] {
            
            let finalRates : [CurrencyRate] = rates.compactMap({ CurrencyRate(currencyIso: $0.key, rate: $0.value, timestamp: timestamp) })
            let conversion = Converter(base: base, timestamp: timestamp, rates: finalRates)
            
            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
