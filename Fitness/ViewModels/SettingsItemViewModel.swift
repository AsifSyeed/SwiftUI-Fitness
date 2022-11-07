//
//  SettingsItemViewModel.swift
//  Fitness
//
//  Created by BS901 on 10/27/22.
//

import Foundation

extension SettingsViewModel {
    struct SettingsItemViewModel {
        let title: String
        let iconName: String
        let type: SettingsItemType
    }
    
    enum SettingsItemType {
        case account
        case mode
        case privacy
        case logout
    }
}
