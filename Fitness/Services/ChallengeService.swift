//
//  CreateChallengeService.swift
//  Fitness
//
//  Created by BS901 on 10/25/22.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    func create(_ challenge: Challenge) -> AnyPublisher<Void, FitnessError>
    func observeChallenge(userId: UserId) -> AnyPublisher<[Challenge], FitnessError>
}

final class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, FitnessError> {
        return Future<Void, FitnessError> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(.default() ))
            }
        }.eraseToAnyPublisher()
    }
    
    func observeChallenge(userId: UserId) -> AnyPublisher<[Challenge], FitnessError> {
        let query = db.collection("challenges").whereField("userId", isEqualTo: userId)
        
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap { snapshot -> AnyPublisher<[Challenge], FitnessError> in
                do {
                    let challenges = try snapshot.documents.compactMap {
                        try $0.data(as: Challenge.self)
                    }
                    
                    return Just(challenges)
                        .setFailureType(to: FitnessError.self)
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
                }
                
            }.eraseToAnyPublisher()
    }
}
