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
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropDownView(viewModel: $viewModel.dropdowns[index])
        }
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: viewModel.displayedOptions.indices.map { index in
                let option = viewModel.displayedOptions[index]
                return ActionSheet.Button.default(Text(option.formatted)) {
                    viewModel.send(action: .selectOption(index: index))
                }
            }
        )
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
            .actionSheet(isPresented: Binding<Bool>(get: {
                viewModel.hasSelectedDropdown
            }, set: { _ in })) { actionSheet }
                .navigationBarTitle("Create Challenge")
                .navigationBarBackButtonHidden(true)
                .padding(.bottom, 15)
        }
    }
}
