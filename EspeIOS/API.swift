//
//  API.swift
//  EspeIOS
//
//  Created by Adrian Ludvigsson on 2019-10-12.
//  Copyright © 2019 Adrian Ludvigsson. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class NetworkManagerDevices: ObservableObject {
    var didChange = PassthroughSubject<NetworkManagerDevices, Never>()
    @Published var devices = [Device]()

    init() {
        guard let url = URL(string: "http://144.202.14.56/devices") else {return}
          
         URLSession.shared.dataTask(with: url) { data, _, _ in
        
            guard let data = data else { return }
                let devices = try! JSONDecoder().decode([Device].self, from: data)
                
            DispatchQueue.main.async {
                    print(devices)
                    self.devices = devices
                }
        }.resume()
        print(self.devices)
    }
}

class NetworkManagerEvents: ObservableObject {
    var didChange = PassthroughSubject<NetworkManagerEvents, Never>()
    @Published var event = [Event]()

    init(){
        guard let url = URL(string: "http://144.202.14.56/events/1") else {return}
         URLSession.shared.dataTask(with: url) { data, _, _ in
        
            guard let data = data else { return }
                let event = try! JSONDecoder().decode([Event].self, from: data)
                
            DispatchQueue.main.async {
                    self.event = event
                }
        }.resume()
    }
}



