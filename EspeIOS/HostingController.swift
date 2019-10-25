//
//  HostingController.swift
//  EspeIOS
//
//  Created by Adrian Ludvigsson on 2019-10-15.
//  Copyright © 2019 Adrian Ludvigsson. All rights reserved.
//


import Foundation
import UIKit
import SwiftUI

class HostingController: UIHostingController<AppView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .darkContent
    }
}
