//
//  GameState.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import Foundation

enum GameState {
    case paused
    case running
    
    var string: String {
        switch self {
        case .paused: return "Pause"
        case .running: return "Run"
        }
    }
}
