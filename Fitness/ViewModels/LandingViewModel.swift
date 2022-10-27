//
//  LandingViewModel.swift
//  Fitness
//
//  Created by BS901 on 10/27/22.
//

import Foundation

final class LandingViewModel: ObservableObject {
    @Published var loginSignupPushed = false
    @Published var createPushed = false
    
    let title = "FITNESS"
}
