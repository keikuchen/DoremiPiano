//
//  Note.swift
//  DoremiPiano
//
//  Created by Kei Kashi on 2020/06/17.
//

import SwiftUI
import CoreLocation

struct Note: Hashable, Codable, Identifiable {
    var id: Int
    var audioName: String
    var audioPitch: Int
    var defaultRole: Int
}
