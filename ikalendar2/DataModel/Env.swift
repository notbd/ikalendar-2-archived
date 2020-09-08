//
//  Env.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import Foundation

final class Env: ObservableObject {
    
    @Published var catalog: RotationCatalog?
    @Published var loadingStatus: loadingStatusType
    
    @Published var isSettingsPresented = false
    
    var defaultLaunchMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT)
    {
        willSet {
            UserDefaults.standard.set(newValue, forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT)
        }
    }
    
    var isAutoRefreshEnabled: Bool = UserDefaults.standard.bool(forKey: Constants.USERDEFAULTS_KEY_AUTOREFRESH_BOOL)
    {
        willSet {
            UserDefaults.standard.set(newValue, forKey: Constants.USERDEFAULTS_KEY_AUTOREFRESH_BOOL)
        }
    }
    
    var nextRefreshTime: Date?
    
    enum loadingStatusType {
        case loading
        case loaded
        case failure
    }
    
    // Starting Application Env
    init() {
        self.loadingStatus = .loading
        self.catalog = RotationCatalog()
        self.getRotations()
    }
    
    // dummy Env for testing
    init(isForTest: Bool) {
        self.loadingStatus = .loaded
        self.catalog = RotationCatalog(isForTest: true)
    }
    
    func getRotations() {
        
        self.loadingStatus = .loading
        
        // Create a URL object
        let url = URL(string: Constants.ROTATIONS_URL)
        
        guard url != nil else {
            dump("error: url invalid")
            
            DispatchQueue.main.async {
                self.loadingStatus = .failure
            }
            
            return // handle error
        }
        
        // Get a URLSession object
        let session = URLSession.shared
        
        // Get a data task from URLSession
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check for errors
            if data == nil {
                dump("error: empty data fetched")
                
                DispatchQueue.main.async {
                    self.loadingStatus = .failure
                }
                
                return
            }
            
            if error != nil {
                dump("error: \(String(describing: error))")
                
                DispatchQueue.main.async {
                    self.loadingStatus = .failure
                }
                
                return // handle error
            }
            
            do {
                
                // Parse data into rotations
                let decoder = JSONDecoder()
                
                let fetched_catalog = try decoder.decode(RotationCatalog.self, from:data!)
                
                DispatchQueue.main.async {
                    self.catalog = fetched_catalog
                    self.nextRefreshTime = Date(timeIntervalSince1970: (self.catalog?.ranked![0].end_time)!)
                    self.loadingStatus = .loaded
                }
                
            }
            catch {
                // error
                dump("data fetch error")
                
                DispatchQueue.main.async {
                    self.loadingStatus = .failure
                }
            }
            
        }
        
        // Kick off the task
        dataTask.resume()
    }
}
