//
//  ProgressCircleView.swift
//  Fitness
//
//  Created by BS901 on 11/7/22.
//

import SwiftUI

struct ProgressCircleView: View {
    let viewModel: ProgressCircleViewModel
    @State private var percentage: CGFloat = 0
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(Color.circleOutline)
            Circle()
                .trim(from: 0, to: CGFloat(viewModel.percentageComplete))
                .stroke(style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(Color.circleTrack)
                .rotationEffect(.init(degrees: -90))
            VStack {
                if viewModel.shouldShowTitle {
                    Text(viewModel.message)
                }
                Text(viewModel.title)
            }
            .padding(25)
            .font(Font.caption.weight(.semibold))
        }.onAppear {
            withAnimation(.spring(response: 4)) {
                percentage = CGFloat(viewModel.percentageComplete)
            }
        }
    }
}

struct Previews_ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(viewModel: .init(title: "Day", message: "3 of 7", percentageComplete: 0.43))
            .frame(width: 200, height: 200)
            .preferredColorScheme(.dark)
        
        ProgressCircleView(viewModel: .init(title: "Day", message: "3 of 7", percentageComplete: 0.43))
            .frame(width: 200, height: 200)
            .preferredColorScheme(.light)
    }
}
