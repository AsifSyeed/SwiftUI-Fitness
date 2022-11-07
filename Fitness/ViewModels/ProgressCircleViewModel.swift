//
//  ProgressCircleViewModel.swift
//  Fitness
//
//  Created by BS901 on 11/7/22.
//

import Foundation

struct ProgressCircleViewModel {
    let title: String
    let message: String
    let percentageComplete: Double
    var shouldShowTitle: Bool {
        percentageComplete <= 1
    }
}
