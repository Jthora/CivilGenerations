//
//  GameSpeed.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import Foundation

enum GameSpeed: Int {
    case superSlow
    case verySlow
    case slow
    case normal
    case fast
    case veryFast
    case superFast
    
    var string: String {
        switch self {
        case .superSlow: return "Super Slow"
        case .verySlow: return "Very Slow"
        case .slow: return "Slow"
        case .normal: return "Normal"
        case .fast: return "Fast"
        case .veryFast: return "Very Fast"
        case .superFast: return "Super Fast"
        }
    }
    
    var icon: String {
        switch self {
        case .superSlow: return "🐌"
        case .verySlow: return "🐢"
        case .slow: return "🐇"
        case .normal: return "🚙"
        case .fast: return "🏎"
        case .veryFast: return "✈️"
        case .superFast: return "🚀"
        }
    }
}
