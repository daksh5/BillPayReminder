//
//  reminder.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 4/6/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import Foundation

struct Reminder {
    public var name: String
    public var amount: Int
    public var date: String
    public var category: String
    public var id: String
    
    init(name: String, amount: Int, date:String, category: String, id: String) {
        self.name = name
        self.amount = amount
        self.date = date
        self.category = category
        self.id = id
    }
}
