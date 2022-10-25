//
//  CreateView.swift
//  Fitness
//
//  Created by BS901 on 10/20/22.
//

import SwiftUI

struct CreateView: View {
    @StateObject var viewModel = CreateChallengeViewModel()
    
    var dropdownList: some View {
        Group {
            DropDownView(viewModel: $viewModel.exerciseDropdown)
            DropDownView(viewModel: $viewModel.startAmountDropdown)
            DropDownView(viewModel: $viewModel.increaseDropdown)
            DropDownView(viewModel: $viewModel.lengthDropdown)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(action: .createChallenge)
                }) {
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                }
            }
            .navigationBarTitle("Create Challenge")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
        }
    }
}
