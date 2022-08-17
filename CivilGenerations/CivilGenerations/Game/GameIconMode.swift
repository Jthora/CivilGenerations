//
//  GameIconMode.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/17/22.
//

import Foundation

enum GameIconMode {
    case icons
    case numbers
    
    var icon: String {
        switch self {
        case .icons: return "🏠"
        case .numbers: return "🔢"
        }
    }
}
