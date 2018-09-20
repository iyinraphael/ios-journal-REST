//
//  EntryController.swift
//  Journal
//
//  Created by Iyin Raphael on 9/20/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

class EntryController{
    
    static let baseURL: URL = URL(string: "https://journal-e3f26.firebaseio.com/")!
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void){
        let url = EntryController.baseURL.appendingPathComponent(entry.identifier).appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.t
    }
    var entries: [Entry] = []
}
