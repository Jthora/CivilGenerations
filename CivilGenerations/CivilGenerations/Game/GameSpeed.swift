//
//  GameSpeed.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import Foundation

enum GameSpeed: Int {
    case superSlow = 64
    case verySlow = 32
    case slow = 16
    case normal = 8
    case fast = 4
    case veryFast = 2
    case superFast = 1
    
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
}
