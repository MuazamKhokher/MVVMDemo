//
//  File.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
