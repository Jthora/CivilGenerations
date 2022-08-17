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
                        HStack {
                            Group {
                                HStack {
                                    Button(action: {
                                        gameCore.gameSpeed = GameSpeed(rawValue: gameCore.gameSpeed.rawValue - 1) ?? .superSlow
                                    }, label: {
                                        Text("➖")
                                            .frame(width: 36, height: 40)
                                            .font(.system(size: 32))
                                    })
                                    Text(gameCore.gameSpeed.icon)
                                        .frame(width: 36, height: 40)
                                        .font(.system(size: 32))
                                    Button(action: {
                                        gameCore.gameSpeed = GameSpeed(rawValue: gameCore.gameSpeed.rawValue + 1) ?? .superFast
                                    }, label: {
                                        Text("➕")
                                            .frame(width: 36, height: 40)
                                            .font(.system(size: 32))
                                    })
                                    Spacer()
                                }
                            }
                            Group {
                                HStack {
                                    Button(action: {
                                        gameCore.reset()
                                    }, label: {
                                        Text("🔄")
                                            .frame(width: 40, height: 40)
                                            .font(.system(size: 36))
                                    })
                                    Button(action: {
                                        switch gameCore.gameState {
                                            case .paused: gameCore.start()
                                            case .running: gameCore.pause()
                                        }
                                    }, label: {
                                        Text(gameCore.gameState.icon)
                                            .frame(width: 40, height: 40)
                                            .font(.system(size: 36))
                                    })
                                }
                            }
                            Group {
                                Button(action: {
                                    switch gameCore.iconMode {
                                        case .icons: gameCore.iconMode = .numbers
                                        case .numbers: gameCore.iconMode = .icons
                                    }
                                }, label: {
                                    Text(gameCore.iconMode.icon)
                                        .frame(width: 40, height: 40)
                                        .font(.system(size: 36))
                                        .padding()
                                })
                            }
                        }
                        .background(.white)
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
