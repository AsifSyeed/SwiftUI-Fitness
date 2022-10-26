//
//  ChallengeListViewModel.swift
//  Fitness
//
//  Created by BS901 on 10/26/22.
//

import SwiftUI

final class ChallengListViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
    }
}
