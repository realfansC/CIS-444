//
//  LocalJsonService.swift
//  CaptionApp-Lecture-06
//
//  Created by Rebecca  Slatkin on 1/29/20.
//  Copyright © 2020 Syracuse University. All rights reserved.
//

import Foundation

class LocalJsonService {
    static func readJSON(from fileName: String) throws -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            json = try JSONSerialization.jsonObject(with: data)
        }
        return json
    }
}

/*  // Import quotes from local JSON file
      let fileName = "theoffice"
      do {
          let captions = try LocalJsonService.readJSON(from: fileName) as! NSDictionary
          print("captions count: \(captions.count)")
      } catch let error as NSError {
          print("Failed to \(error.localizedDescription)")
      }*/
