//
//  ChallengeListView.swift
//  Fitness
//
//  Created by BS901 on 10/26/22.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var viewModel = ChallengListViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry") {
                        viewModel.send(action: .retry)
                    }
                    .padding(10)
                    .background(Rectangle().fill(Color.red).cornerRadius(5))
                }
            } else {
                mainContentView
            }
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible(), spacing: 20), .init(.flexible())], spacing: 20) {
                    ForEach(viewModel.itemViewModels, id: \.id) { viewModel in
                        ChallengeItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }.padding(10)
        }
        .sheet(isPresented: $viewModel.showingCreateModal) {
            NavigationView {
                CreateView()
            }.preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .navigationBarItems(
            trailing: Button {
                viewModel.send(action: .create)
            } label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            })
        .navigationTitle(viewModel.title)
    }
}
