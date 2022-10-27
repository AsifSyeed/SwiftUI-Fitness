//
//  TextFieldRoundedStyle.swift
//  Fitness
//
//  Created by BS901 on 10/27/22.
//

import SwiftUI

struct TextFieldCustomRoundedStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Color(.systemGray4))
            .padding()
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    Color.primary
                )
            )
            .padding(.horizontal, 15)
    }
}
