//
//  Entry.swift
//  Journal
//
//  Created by Iyin Raphael on 9/20/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

struct Entry: Codable, Equatable{
    var title: String
    var bodyText: String
    let timestamp: Date
    let identifier: String
    
    init(title: String, bodyText: String, timestamp: Date = Date(), identifier: String = UUID().uuidString){
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.identifier = identifier
    }
}
