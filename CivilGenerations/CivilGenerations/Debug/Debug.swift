//
//  Log.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/18/22.
//

import Foundation

let DEBUG_LOG_ENABLED = false

final class Debug {
    static func log(_ text:String) {
        guard DEBUG_LOG_ENABLED else {return}
        print(text)
    }
}
