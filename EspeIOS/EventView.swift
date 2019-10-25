//
//  EventView.swift
//  EspeIOS
//
//  Created by Adrian Ludvigsson on 2019-10-13.
//  Copyright © 2019 Adrian Ludvigsson. All rights reserved.
//

import SwiftUI


struct EventView: View {
    @ObservedObject var networkManager = NetworkManagerEvents()
    @State var pickerSelectedItem = 0

    var body: some View {
       
        ZStack{
            Color(#colorLiteral(red: 0.6509822011, green: 0.8906581998, blue: 0.9126955271, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Text("Medicinering").font(.system(size: 42)).fontWeight(.heavy)
                    .padding(.top, 24)
                Picker(selection: $pickerSelectedItem, label: Text("")){
                    Text("Senast").tag(1)
                    Text("Statistik").tag(0)
                }.pickerStyle(SegmentedPickerStyle()).shadow(radius: 5, x:5 , y:5).padding(.bottom, 24).frame(width: 220).animation(.linear)
                
                if pickerSelectedItem == 1{
                    EventCard(event: networkManager.event.last ?? Event(id: 0, datetime: "", count: 0))
                        .transition(.slide)
                    
                }
                
                if pickerSelectedItem == 0{
                    HStack{
                        VStack{
                        Text("8pm").padding(.bottom, 40)
                        Text("7pm").padding(.top, 40).padding(.bottom, 10)
                        }
                        
                        BarView(value: 100, title: "Må")
                        BarView(value: 110, title: "Ti")
                        BarView(value: 125, title: "On")
                        BarView(value: 104, title: "To")
                        BarView(value: 71, title: "Fr")
                        BarView(value: 139, title: "Lö")
                        BarView(value: 78, title: "Sö")
                        
                    }.padding(.trailing, 35)
                    
                 
                }
            
                Spacer()
            

            
            }
            }
    }
    
}
    



struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}



struct EventCard: View {
    let event: Event
    var body: some View {
        ZStack{
            Rectangle().frame(width: 280, height: 280)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(55)
                .shadow(radius: 10,x:5, y: 5)
            
            //str1 = createTimeString(event: networkManager.events.first)
            VStack(alignment: .center) {
                Text(event.dateString).font(.system(size: 24)).fontWeight(.light).shadow(radius: 1, x: 1, y:1)
                Text(event.timeString).font(.system(size: 80)).fontWeight(.light).shadow(radius: 1, x: 2, y:2)
                Text("\(event.count) x 80mg Elvanse ").font(.system(size: 24)).fontWeight(.light).shadow(radius: 1, x: 1, y:1)
            }
        }
    }     
}

struct BarView: View{
    var value: CGFloat
    var title: String
    var body: some View{
        
      
            VStack{
                ZStack(alignment: .bottom){
                    Capsule().frame(width: 35, height: 250)
                        .foregroundColor(Color(#colorLiteral(red: 0.6053785682, green: 0.8042572141, blue: 0.8260808587, alpha: 1)))
                    Capsule().frame(width: 35, height: value)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    
                }
                Text(title)
            }
        
        
    }
    
    
}
