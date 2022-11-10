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
    @Published private(set) var error: FitnessError?
    @Published private(set) var isLoading = false
    @Published var showingCreateModal = false
    let title = "Challenges"
    
    enum Action {
        case retry
        case create
        case timeChange
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
        observeChallenges()
    }
    
    func send(action: Action) {
        switch action {
        case .retry:
            observeChallenges()
        case .create:
            showingCreateModal = true
        case .timeChange:
            cancellables.removeAll()
            observeChallenges()
        }
    }
    
    private func observeChallenges() {
        userService.currentUserPublisher()
            .compactMap { $0?.uid }
            .flatMap { [weak self] userId -> AnyPublisher<[Challenge], FitnessError> in
                guard let self = self else { return Fail(error: .default()).eraseToAnyPublisher() }
                return self.challengeService.observeChallenge(userId: userId)
            }.sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] challenges in
                guard let self = self else { return }
                self.error = nil
                self.isLoading = false
                self.showingCreateModal = false
                self.itemViewModels = challenges.map { challenge in
                    .init(
                        challenge,
                        onDelete: { [weak self] id in
                            self?.deleteChallenge(id)
                        },
                        onToggleComplete: { [weak self] id, activities in
                            self?.updateChallenge(id: id, activities: activities)
                            
                        }
                    )
                }
            }.store(in: &cancellables)
    }
    
    private func deleteChallenge(_ challengeId: String) {
        print(challengeId)
        
        challengeService.delete(challengeId).sink { completion in
            switch completion {
            case let .failure(error):
                print(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    private func updateChallenge(id: String, activities: [Activity]) {
        challengeService.updateChallenge(id, activities: activities).sink { completion in
            switch completion {
            case let .failure(error):
                print(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
