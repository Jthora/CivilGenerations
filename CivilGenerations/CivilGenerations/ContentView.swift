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
                    // Top Details Bar
                    Group{
                        HStack {
                            Text("➰: \(gameCore.generations)")
                                .frame(width: 100, height: 40, alignment: .leading)
                                .font(.system(size: 16))
                                .clipped()
                            Spacer()
                        }
                        .background(.white)
                    }.frame(maxHeight: .infinity, alignment: .top)
                    
                    // Midle Empty Space (for visibility into Scene)
                    Spacer()
                    
                    // Bottom Control Bar
                    Group{
                        HStack {
                            Group {
                                VStack {
                                    Group {
                                        Text(gameCore.gameSpeed.string)
                                            .font(.system(size: 12))
                                    }.frame(maxWidth: .infinity, maxHeight: 10, alignment: .center)
                                    HStack {
                                        Button(action: {
                                            gameCore.gameSpeed = GameSpeed(rawValue: gameCore.gameSpeed.rawValue - 1) ?? .superSlow
                                        }, label: {
                                            Text("➖")
                                                .frame(width: 30, height: 30)
                                                .font(.system(size: 30))
                                        })
                                        Text(gameCore.gameSpeed.icon)
                                            .frame(width: 32, height: 30)
                                            .font(.system(size: 30))
                                        Button(action: {
                                            gameCore.gameSpeed = GameSpeed(rawValue: gameCore.gameSpeed.rawValue + 1) ?? .superFast
                                        }, label: {
                                            Text("➕")
                                                .frame(width: 30, height: 30)
                                                .font(.system(size: 30))
                                        })
                                    }
                                }
                            }.frame(alignment: .leading)
                            Spacer()
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
