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
        request.httpMethod = "PUT"
        do{
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(entry)

        }catch{
            NSLog("Could not upload entry: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("error putting message threads: \(error)")
                completion(error)
            }
        }
    }
    
    //MARK:- CRUD
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void){
        let entry = Entry(title: title, bodyText: bodyText)
        entries.append(entry)
        put(entry: entry, completion: completion)
    }
    
    func updateEntry(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void){
        guard let index = entries.index(of: entry) else {return}
        var scratch = entry
        scratch.title = entry.title
        scratch.bodyText = entry.bodyText
        entries.remove(at: index)
        entries.insert(scratch, at: index)
        put(entry: scratch, completion: completion)
    }
    
    
    func fetchEntries(completion: @escaping (Error?) -> Void){
        let url = EntryController.baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("error putting message threads: \(error)")
                completion(error)
            }
             guard let data = data else {return}
          
            do{
                let dict = try JSONDecoder().decode([String: Entry].self, from: data)
                let decodedEntries = Array(dict.values)
                self.entries = decodedEntries.sorted{ return $0.timestamp < $1.timestamp }
                completion(nil)
            }catch{
                NSLog("error decoding: \(error)")
            }
        }.resume()

    }
    
    
    var entries: [Entry] = []
}
