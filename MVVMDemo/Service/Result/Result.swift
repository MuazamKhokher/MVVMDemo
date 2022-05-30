//
//  Result.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
