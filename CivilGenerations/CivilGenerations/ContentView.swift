//
//  ContentView.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import SwiftUI
import CoreData
import SpriteKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var gameCore = GameCore.shared
    
    var body: some View {
        let screenWidth  = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        ZStack {
            Group {
                SpriteView(scene: gameCore.scene)
                    .frame(width: screenWidth, height: screenHeight)
                    .ignoresSafeArea()
            }
            Group {
                VStack {
                    Spacer()
                    
                    Group{
                        Button(action: {
                            switch gameCore.gameState {
                                case .paused: gameCore.start()
                                case .running: gameCore.pause()
                            }
                        }, label: {
                            Text("⏯")
                                .frame(width: 40, height: 40)
                                .font(.system(size: 40))
                                .padding()
                        })
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
