//
//  LoginSignupView.swift
//  Fitness
//
//  Created by BS901 on 10/27/22.
//

import SwiftUI

struct LoginSignupView: View {
    @ObservedObject var viewModel: LoginSignupViewModel
    
    var emailTextField: some View {
        TextField("Email", text: $viewModel.emailText)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var passwordTextField: some View {
        SecureField("Password", text: $viewModel.passwordText)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var actionButton: some View {
        Button(viewModel.buttonTitle) {
            
        }.padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color(.systemPink))
            .cornerRadius(16)
            .padding()
    }
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(viewModel.subTitle)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            Spacer()
                .frame(height: 50)
            emailTextField
            passwordTextField
            actionButton
            Spacer()
        }.padding()
    }
}
