//
//  ContentView.swift
//  Fitness
//
//  Created by BS901 on 10/20/22.
//

import SwiftUI
import CoreData

struct LandingView: View {
    @StateObject private var viewModel = LandingViewModel()
    
    var title: some View {
        Text(viewModel.title)
            .font(.system(size: 64,
                          weight: .bold))
            .foregroundColor(.white)
    }
    
    var createButton: some View {
        Button(action: {
            viewModel.createPushed = true
        }) {
            HStack(spacing: 15) {
                Spacer()
                Image(systemName: "plus.circle")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Text("Create a challenge")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
            }
        }.padding(15)
            .buttonStyle(PrimaryButtonStyle())
    }
    
    var alreadyAccountButton: some View {
        Button("I already have an account") {
            viewModel.loginSignupPushed = true
        }.foregroundColor(.white)
    }
    
    var backgroundImage: some View {
        Image("fitness_bg")
            .resizable()
            .aspectRatio(
                contentMode: .fill
            ).overlay(Color.black.opacity(0.4))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(
                        height: proxy.size.height * 0.08
                    )
                    title
                    Spacer()
                    NavigationLink(
                        destination: CreateView(),
                        isActive: $viewModel.createPushed) {}
                    createButton
                    NavigationLink(
                        destination: LoginSignupView(
                            viewModel: .init(mode: .login, isPushed: $viewModel.loginSignupPushed)
                        ),
                        isActive: $viewModel.loginSignupPushed){}
                    alreadyAccountButton
                }
                .padding(.bottom, 15)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    backgroundImage
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }.accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
