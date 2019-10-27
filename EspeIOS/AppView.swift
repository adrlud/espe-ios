//
//  AppView.swift
//  EspeIOS
//
//  Created by Adrian Ludvigsson on 2019-10-13.
//  Copyright © 2019 Adrian Ludvigsson. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var settings: UserDevices
    
    var body: some View {

        ZStack{
           Color(#colorLiteral(red: 0.6509822011, green: 0.8906581998, blue: 0.9126955271, alpha: 1)).edgesIgnoringSafeArea(.all)
            TabView{
                
                
                EventView()
                    .tabItem{
                        Image(systemName: "multiply.circle.fill")
                        
                }.tag(0)
                
                ContentView()
                    .tabItem{
                        Image(systemName: "list.dash")
                }.tag(1)
                
            }
            
        }
      
    }
        
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView().environmentObject(UserDevices())
    }
}
