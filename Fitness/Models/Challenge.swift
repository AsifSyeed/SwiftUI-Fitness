//
//  Challenge.swift
//  Fitness
//
//  Created by BS901 on 10/25/22.
//

import Foundation

struct Challenge: Hashable, Codable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}
