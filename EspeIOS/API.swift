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
    
    
    
    @Published var devices = [Device]() {
        didSet {}
    }
    
     @Published var change: Bool = false {
        didSet {
            _devicesDidChange.send(devices)
            
        }
    }
    
    
    private let _devicesDidChange = PassthroughSubject<[Device], Never>()
    
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

class NetworkManagerDevice: ObservableObject {
    var didChange = PassthroughSubject<NetworkManagerDevice, Never>()
    @Published var device: [Device] = []
    
    
    private let _textDidChange = PassthroughSubject<String, Never>()
    
    func load(id: Int){
        guard let url = URL(string: "http://144.202.14.56/device/\(id)") else {return}
         URLSession.shared.dataTask(with: url) { data, _, _ in
        
            guard let data = data else { return }
                let device = try! JSONDecoder().decode(Device.self, from: data)
                
            DispatchQueue.main.async {
                    self.device = [device]
                }
        }.resume()
    }
}



class NetworkManagerUpload{
    func updateDeviceActiveStatus(device_id: Int, active: Bool) {
        
        let url = URL(string: "http://144.202.14.56/device/\(device_id)/\(active ? "activate" : "deactivate")")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "active": active
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString ?? "")")
        }
        task.resume()
    }
}

