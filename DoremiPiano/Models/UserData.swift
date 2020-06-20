//
//  UserData.swift
//  DoremiPiano
//
//  Created by Kei Kashi on 2020/06/17.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var notes = noteData
}
