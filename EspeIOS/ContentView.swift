//
//  ContentView.swift
//  EspeIOS
//
//  Created by Adrian Ludvigsson on 2019-10-12.
//  Copyright © 2019 Adrian Ludvigsson. All rights reserved.
//

import SwiftUI
import UIKit
import Combine


struct ContentView: View {
    @EnvironmentObject var networkManager: NetworkManagerDevices
    
    //var testData: [Device] = [Device(name: "Max", id: 0, active: true, connected: false)]
    var body: some View {
    
        VStack() {
            ScrollView(.vertical){
                Text("Enheter").font(.system(size: 42)).fontWeight(.heavy)
                .padding(.top, 24)
                VStack(alignment: .leading) {
                    ForEach(networkManager.devices){
                        DeviceRowView(device: $0)
                    }
                    AddButton()
                }.padding(.horizontal, 8)
                
            }
            
        }.background(Color(#colorLiteral(red: 0.6509822011, green: 0.8906581998, blue: 0.9126955271, alpha: 1)).edgesIgnoringSafeArea(.all))
     
    
    }
}




struct DeviceRowView: View {
    var device: Device
    @State var isExpanded = false
   
    @EnvironmentObject var net: NetworkManagerDevices
    var body: some View {
        return ZStack {
            Rectangle().foregroundColor(.white).cornerRadius(8).shadow(radius: 10, x:3, y: 3)
            
            VStack(alignment: .leading) {
                DeviceRowHeader(device: device, isExpanded: isExpanded).onTapGesture {
                    self.isExpanded.toggle()
                }
                if isExpanded {
                    DeviceRowBody(device: device, isExpanded: isExpanded)
                }
            }.padding([.top, .horizontal, .bottom], 20)
    
        }
    }
    
}



struct AddButton: View{
    var body: some View{
   
        Button(action: {
            print("Delete tapped!")
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.caption)
                
                Text("Lägg till enhet")
                    .fontWeight(.semibold)
                    .font(.caption)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
      
            .cornerRadius(40)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct DeviceRowHeader: View {
    var device: Device
    var  isExpanded = false
    
    @EnvironmentObject var networkManager: NetworkManagerDevices
    
    
    var body: some View {
        HStack {
            if device.active == true {
                Circle().frame(width: 20).padding(.trailing, 10).foregroundColor(.green)
            } else {
                Circle().frame(width: 20).padding(.trailing, 10).foregroundColor(.red)
            }
            
            VStack(alignment: .leading) {
                Text(device.name).font(.custom("System", size: 18))
                Text("144.202.14.56").font(.subheadline).fontWeight(.ultraLight)
            }
            Spacer()
            
            if isExpanded {
                Image(systemName: "chevron.down")
            } else {
                Image(systemName: "chevron.right")
            }
        }
    }
}


struct DeviceRowBody: View {
    var device: Device
    var isExpanded = false
    @State var medicine = ""
    @State var activeIngredient = ""
    @EnvironmentObject var networkManager: NetworkManagerDevices
    

    var body: some View {
        
        let firstBinding = Binding( get: { self.device.active }, set: {
            self.device.active = $0
            self.sendSettings()
            self.networkManager.change.toggle()
    
     } )
       return VStack {
            Toggle(isOn: firstBinding) {
                Text("Active")
            }
            TextField("Medicine", text: $medicine)
            TextField("Active ingredient", text: $medicine)
        }
    }
     
    func sendSettings(){
        NetworkManagerUpload().updateDeviceActiveStatus(device_id: self.device.id, active: self.device.active)
    }

}



struct RoundedButton : View {
    var body: some View {
        Button(action: {}) {

            HStack {
                Spacer()
                Text("Save")
                    .font(.headline)
                    .foregroundColor(Color.white)
                Spacer()
            }
        }
        .padding(.vertical, 10.0)
        .background(Color.red)
        .cornerRadius(15)
        .padding(.horizontal, 50)
    }

}


