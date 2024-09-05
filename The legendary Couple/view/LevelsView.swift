//
//  LevelsView.swift
//  The legendary Couple
//
//  Created by Artur on 05.09.2024.
//

import SwiftUI

struct LevelsView: View {
    @StateObject private var saveBac = SaveBac()
    @StateObject private var saveLevel = SaveLevel()
    @EnvironmentObject var savePoints: SavePoints
    @State private var level1 = false
    @State private var level2 = false
    @State private var level3 = false
    @State private var level4 = false
    @State private var level5 = false
    @State private var level6 = false
    @State private var level7 = false
    @State private var level8 = false
    @State private var level9 = false
    @State private var level10 = false
    @State private var level11 = false
    @State private var level12 = false
    @State private var level13 = false
    @State private var level14 = false
    @State private var level15 = false
    @State private var level16 = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            BackView(number: saveBac.value)
            VStack{
                HStack{
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image("Frame 4")
                    })
                    
                    Image("Levels").padding(.leading,20)
                    Spacer()
                }.padding(.leading,30)
                    .padding(.top,60)
                
                
                VStack{
                    
                    HStack{
                       
                        ZStack{
                            Image("l1")
                            Button(action: {
                                level1.toggle()
                            }, label: {
                                Image("Open")
                            
                            }).padding(.top,60)
                        }
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 1) ? "ll2" : "l2")
                            Button(action: {
                              
                                if !saveLevel.retrieve(for: 1){
                                    if savePoints.value > 100{
                                        saveLevel.save(true, for: 1)
                                        savePoints.saveValue(-100)
                                    }
                                    
                                }else{
                                    level2.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 1) ? "Open" : "p2")
                            
                            }).padding(.top,60)
                        }
                        
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 2) ? "ll3" : "l3")
                            Button(action: {
                                if !saveLevel.retrieve(for: 2){
                                    if savePoints.value > 150{
                                        saveLevel.save(true, for: 2)
                                        savePoints.saveValue(-150)
                                    }
                                    
                                }else{
                                    level3.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 2) ? "Open" : "p3")
                            
                            }).padding(.top,60)
                        }
                       
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 3) ? "ll4" : "l4")
                            Button(action: {
                                if !saveLevel.retrieve(for: 3){
                                    if savePoints.value > 200{
                                        saveLevel.save(true, for: 3)
                                        savePoints.saveValue(-200)
                                    }
                                    
                                }else{
                                    level4.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 3) ? "Open" : "p4")
                            
                            }).padding(.top,60)
                        }
                    
                    }.padding(.top,60)
                    
                    
                    HStack{
                       
                        ZStack{
                            Image(saveLevel.retrieve(for: 4) ? "ll5" : "l5")
                            Button(action: {
                                if !saveLevel.retrieve(for: 4){
                                    if savePoints.value > 250{
                                        saveLevel.save(true, for: 4)
                                        savePoints.saveValue(-250)
                                    }
                                    
                                }else{
                                    level5.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 4) ? "Open" : "p5")
                            
                            }).padding(.top,60)
                        }
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 5) ? "ll6" : "l6")
                            Button(action: {
                                if !saveLevel.retrieve(for: 5){
                                    if savePoints.value > 300{
                                        saveLevel.save(true, for: 5)
                                        savePoints.saveValue(-300)
                                    }
                                    
                                }else{
                                    level6.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 5) ? "Open" : "p6")
                            
                            }).padding(.top,60)
                        }
                        
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 6) ? "ll7" : "l7")
                            Button(action: {
                                if !saveLevel.retrieve(for: 6){
                                    if savePoints.value > 350{
                                        saveLevel.save(true, for: 6)
                                        savePoints.saveValue(-350)
                                    }
                                    
                                }else{
                                    level7.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 6) ? "Open" : "p7")
                            
                            }).padding(.top,60)
                        }
                       
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 7) ? "ll8" : "l8")
                            Button(action: {
                                if !saveLevel.retrieve(for: 7){
                                    if savePoints.value > 200{
                                        saveLevel.save(true, for: 7)
                                        savePoints.saveValue(-200)
                                    }
                                    
                                }else{
                                    level8.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 7) ? "Open" : "p8")
                            
                            }).padding(.top,60)
                        }
                    
                    }
                 
                    
                    
                    
                    HStack{
                       
                        ZStack{
                            Image(saveLevel.retrieve(for: 8) ? "ll9" : "l9")
                            Button(action: {
                                if !saveLevel.retrieve(for: 8){
                                    if savePoints.value > 450{
                                        saveLevel.save(true, for: 8)
                                        savePoints.saveValue(-450)
                                    }
                                    
                                }else{
                                    level9.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 8) ? "Open" : "p9")
                            
                            }).padding(.top,60)
                        }
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 9) ? "ll10" : "l10")
                            Button(action: {
                                if !saveLevel.retrieve(for: 9){
                                    if savePoints.value > 550{
                                        saveLevel.save(true, for: 9)
                                        savePoints.saveValue(-550)
                                    }
                                    
                                }else{
                                    level10.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 9) ? "Open" : "p10")
                            
                            }).padding(.top,60)
                        }
                        
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 10) ? "ll11" : "l11")
                            Button(action: {
                                if !saveLevel.retrieve(for: 10){
                                    if savePoints.value > 550{
                                        saveLevel.save(true, for: 10)
                                        savePoints.saveValue(-550)
                                    }
                                    
                                }else{
                                    level11.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 10) ? "Open" : "p11")
                            
                            }).padding(.top,60)
                        }
                       
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 11) ? "ll12" : "l12")
                            Button(action: {
                                if !saveLevel.retrieve(for: 11){
                                    if savePoints.value > 600{
                                        saveLevel.save(true, for: 11)
                                        savePoints.saveValue(-600)
                                    }
                                    
                                }else{
                                    level12.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 11) ? "Open" : "p12")
                            
                            }).padding(.top,60)
                        }
                    
                    }
                    
                    
                   
                    HStack{
                       
                        ZStack{
                            Image(saveLevel.retrieve(for: 12) ? "ll13" : "l13")
                            Button(action: {
                                if !saveLevel.retrieve(for: 12){
                                    if savePoints.value > 650{
                                        saveLevel.save(true, for: 12)
                                        savePoints.saveValue(-650)
                                    }
                                    
                                }else{
                                    level13.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 12) ? "Open" : "p13")
                            
                            }).padding(.top,60)
                        }
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 13) ? "ll14" : "l14")
                            Button(action: {
                                if !saveLevel.retrieve(for: 13){
                                    if savePoints.value > 700{
                                        saveLevel.save(true, for: 13)
                                        savePoints.saveValue(-700)
                                    }
                                    
                                }else{
                                    level14.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 13) ? "Open" : "p14")
                            
                            }).padding(.top,60)
                        }
                        
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 14) ? "ll15" : "l15")
                            Button(action: {
                                if !saveLevel.retrieve(for: 14){
                                    if savePoints.value > 750{
                                        saveLevel.save(true, for: 14)
                                        savePoints.saveValue(-750)
                                    }
                                    
                                }else{
                                    level15.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 14) ? "Open" : "p15")
                            
                            }).padding(.top,60)
                        }
                       
                        
                        
                        ZStack{
                            Image(saveLevel.retrieve(for: 15) ? "ll16" : "l16")
                            Button(action: {
                                if !saveLevel.retrieve(for: 15){
                                    if savePoints.value > 800{
                                        saveLevel.save(true, for: 15)
                                        savePoints.saveValue(-800)
                                    }
                                    
                                }else{
                                    level16.toggle()
                                }
                                
                                
                            }, label: {
                                Image(saveLevel.retrieve(for: 15) ? "Open" : "p16")
                            
                            }).padding(.top,60)
                        }
                    
                    }
                    
                    
                }
                
            
                Spacer()
                
            }.fullScreenCover(isPresented: $level1, content: {
                Level1View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level2, content: {
                Level2View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level3, content: {
                Level3View().environmentObject(savePoints)
            })
            
            .fullScreenCover(isPresented: $level4, content: {
                Level4View().environmentObject(savePoints)
            })
            
            .fullScreenCover(isPresented: $level5, content: {
                Level5View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level6, content: {
                Level6View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level7, content: {
                Level7View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level8, content: {
                Level8View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level9, content: {
                Level9View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level10, content: {
                Level10View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level11, content: {
                Level11View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level12, content: {
                Level12View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level13, content: {
                Level13View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level14, content: {
                Level14View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level15, content: {
                Level15View().environmentObject(savePoints)
            })
            .fullScreenCover(isPresented: $level16, content: {
                Level16View().environmentObject(savePoints)
            })
        }
    }
}

#Preview {
    LevelsView()
}
