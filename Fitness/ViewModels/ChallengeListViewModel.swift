//
//  ChallengeListViewModel.swift
//  Fitness
//
//  Created by BS901 on 10/26/22.
//

import SwiftUI
import Combine

final class ChallengListViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    @Published private(set) var itemViewModels: [ChallengeItemViewModel] = []
    let title = "Challenges"
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
        observeChallenges()
    }
    
    private func observeChallenges() {
        userService.currentUser()
            .compactMap { $0?.uid }
            .flatMap { userId -> AnyPublisher<[Challenge], FitnessError> in
                return self.challengeService.observeChallenge(userId: userId)
            }.sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("finished")
                }
            } receiveValue: { challenges in
                self.itemViewModels = challenges.map { .init($0) }
            }.store(in: &cancellables)
    }
}
