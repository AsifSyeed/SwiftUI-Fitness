//
//  ContentView.swift
//  Fitness
//
//  Created by BS901 on 10/20/22.
//

import SwiftUI
import CoreData

struct LandingView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer().frame(
                    height: proxy.size.height * 0.20
                )
                Text("FITNESS")
                    .font(.system(size: 64,
                                  weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Button(action: {}) {
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
                }.padding(.horizontal, 15)
                .buttonStyle(PrimaryButtonStyle())
            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(
                Image("fitness_bg")
                    .resizable()
                    .aspectRatio(
                        contentMode: .fill
                    ).overlay(Color.black.opacity(0.4))
                    .frame(width: proxy.size.width)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
