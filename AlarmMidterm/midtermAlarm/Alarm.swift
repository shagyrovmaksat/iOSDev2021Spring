//
//  Alarm.swift
//  midtermAlarm
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import Foundation

class Alarm {
    var time: String?
    var discription: String?
    var isSwitched: Bool?
    
    init(time: String, discription: String, isSwitched: Bool) {
        self.time = time
        self.discription = discription
        self.isSwitched = isSwitched
    }
}
