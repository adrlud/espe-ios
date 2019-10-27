//
//  EventView.swift
//  EspeIOS
//
//  Created by Adrian Ludvigsson on 2019-10-13.
//  Copyright © 2019 Adrian Ludvigsson. All rights reserved.
//

import SwiftUI





struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}



struct EventView: View {
    @EnvironmentObject var networkManager: NetworkManagerEvents
    
    //var testData: [Device] = [Device(name: "Max", id: 0, active: true, connected: false)]
    var body: some View {
    
        VStack() {
            ScrollView(.vertical){
                Text("Konsumtion").font(.system(size: 42)).fontWeight(.heavy)
                .padding(.top, 24)
                VStack(alignment: .leading) {
                    ForEach(networkManager.event.reversed(), id: \.datetime){
                        EventRowView(event: $0)
                    }
                }.padding(.horizontal, 8)
                
            }
            
        }.background(Color(#colorLiteral(red: 0.6509822011, green: 0.8906581998, blue: 0.9126955271, alpha: 1)).edgesIgnoringSafeArea(.all))
     
    
    }
}


struct EventRowView: View {
    var event: Event
    @State var isExpanded = false
   
    @EnvironmentObject var net: NetworkManagerEvents
    var body: some View {
        return ZStack {
            Rectangle().foregroundColor(.white).cornerRadius(8).shadow(radius: 10, x:3, y: 3)
            
            VStack(alignment: .leading){
                HStack() {
                    Text("\(event.count) x 80mg Elvanse ").font(.system(size: 15)).fontWeight(.light)
                    Spacer()
                    Text(event.dateString).font(.system(size: 15)).fontWeight(.light)
                    Text(event.timeString).font(.system(size: 15)).fontWeight(.light)
                    
                }
               
            }.padding([.top, .horizontal, .bottom], 20)
    
        }
    }
    
}






