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
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                    ForEach(viewModel.itemViewModels, id: \.self) { viewModel in
                        ChallengeItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }
        }.navigationTitle(viewModel.title)
    }
}

struct ChallengeItemView: View {
    private let viewModel: ChallengeItemViewModel
    
    init(viewModel: ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(viewModel.title)
                    .font(.system(size: 24, weight: .bold))
                Text(viewModel.statusText)
                Text(viewModel.dailyIncreaseText)
            }.padding()
            Spacer()
        }
        
        .background(
            Rectangle()
                .fill(Color.darkPrimaryButton)
                .cornerRadius(5)
        ).padding()
        
    }
}
