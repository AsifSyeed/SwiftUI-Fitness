//
//  FitnessError.swift
//  Fitness
//
//  Created by BS901 on 10/25/22.
//

import Foundation

enum FitnessError: LocalizedError {
    case auth(description: String)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .default(description):
            return description ?? "Something went wrong"
        }
    }
}
