//
//  ChallengeListView.swift
//  Fitness
//
//  Created by BS901 on 10/26/22.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var viewModel = ChallengListViewModel()
    
    var body: some View {
        Text("Challenge List")
    }
}
