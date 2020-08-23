//
//  RotationData.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import Foundation

class Data: ObservableObject {
    
    @Published var catalog: RotationCatalog

    init() {
        self.catalog = RotationCatalog()
        self.getRotations()
    }
    
    func getRotations() {
        
        // Create a URL object
        let url = URL(string: Constants.ROTATIONS_URL)
        
        guard url != nil else {
            dump("error: url invalid")
            return // handle error
        }
        
        // Get a URLSession object
        let session = URLSession.shared
        
        // Get a data task from URLSession
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check for errors
            if data == nil {
                dump("error: empty data fetched")
                return
            }
            
            if error != nil {
                dump(error)
                return // handle error
            }
            
            do {
                
                // Parse data into rotations
                let decoder = JSONDecoder()
                
                let fetched_catalog = try decoder.decode(RotationCatalog.self, from:data!)
                
                DispatchQueue.main.async {
                    self.catalog = fetched_catalog
                }
                
            }
            catch {
                // error
                dump("data fetch error")
            }
            
        }
        
        // Kick off the task
        dataTask.resume()
    }
}
