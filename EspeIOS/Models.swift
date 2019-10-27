//
//  Models.swift
//  EspeIOS
//
//  Created by Adrian Ludvigsson on 2019-10-12.
//  Copyright © 2019 Adrian Ludvigsson. All rights reserved.
//

import Foundation


struct Device: Decodable, Identifiable {
    var name: String
    var id: Int
    var active: Bool
    var connected: Bool
}

class UserDevices: ObservableObject {
    @Published var score = 0
}



struct Api: Decodable{
    var result: [Event]
}


struct Event: Decodable {
    let id: Int
    let datetime: String
    let count: Int
    
    var timeString:String{
        get {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "HH:mm"
                  
            let datetimeStripped = datetime.components(separatedBy: ".")
            guard let trimmedDateTime = datetimeStripped.first else { return "..." }
                  
            let date: Date = dateFormatterGet.date(from: trimmedDateTime) ?? Date.init()
            return dateFormatterPrint.string(from: date)
        }
    
        
        }
        var dateString:String{
            get{
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "d MMMM"
                
                let datetimeStripped = datetime.components(separatedBy: ".")
                guard let trimmedDateTime = datetimeStripped.first else { return "..." }
                
                let date: Date = dateFormatterGet.date(from: trimmedDateTime) ?? Date.init()
                if (date.isToay()){ return "Today"}
                return dateFormatterPrint.string(from: date)
            }
        
    }
}
