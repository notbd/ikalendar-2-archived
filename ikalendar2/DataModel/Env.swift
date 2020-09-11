//
//  Env.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import Foundation

final class Env: ObservableObject {
    
    // MARK: - Environment Data
    @Published var catalog: RotationCatalog?
    @Published var loadingStatus: loadingStatusType
    
    var defaultLaunchMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT) {
        willSet {
            UserDefaults.standard.set(newValue, forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT)
        }
    }
    
    // Auto Refresh
    var isAutoRefreshEnabled: Bool = UserDefaults.standard.bool(forKey: Constants.USERDEFAULTS_KEY_AUTOREFRESH_BOOL) {
        willSet {
            UserDefaults.standard.set(newValue, forKey: Constants.USERDEFAULTS_KEY_AUTOREFRESH_BOOL)
        }
    }
    var currRotationEndTime: Date?
//    var isDuringAutoRefresh = false
    
    
    // Loading Status
    enum loadingStatusType {
        case loading
        case loaded
        case failure
        case duringAutoRefresh
    }
    
    // MARK: - Init
    
    // init: Starting Application Env
    init() {
        self.loadingStatus = .loading
        self.catalog = RotationCatalog()
        self.loadRotations()
    }
    
    // init: dummy Env for testing
    init(isForTest: Bool) {
        self.loadingStatus = .loaded
        self.catalog = RotationCatalog(isForTest: true)
    }
    
//    // Concurrency Barrier
//    private let concurrentRotationQueue =
//        DispatchQueue(
//            label: "edu.illinois.tianwei4.ikalendar2.rotationQueue",
//            attributes: .concurrent)
    
    // MARK: - Load Rotations Once
    func loadRotations() {
        
//        concurrentRotationQueue.async(flags: .barrier) {
//        }
        
        DispatchQueue.main.async {
            self.loadingStatus = .loading
        }
        
        guard let url = URL(string: Constants.ROTATIONS_URL) else {
            dump("[load error] URL invalid - check Constants.swift")
            DispatchQueue.main.async {
                simpleHapticError()
                self.loadingStatus = .failure
            }
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // <- optional: handle dataTask other response
            
            // handle dataTask error
            if error != nil {
                dump("[load error] dataTask error: \(String(describing: error))")
                DispatchQueue.main.async {
                    simpleHapticError()
                    self.loadingStatus = .failure
                }
                return
            }
            
            guard let data = data else {
                dump("[load error] Empty data fetched - connection failed?")
                DispatchQueue.main.async {
                    simpleHapticError()
                    self.loadingStatus = .failure
                }
                return
            }
            
            do {
                // Decode JSON data into catalog
                let fetched_catalog = try JSONDecoder().decode(RotationCatalog.self, from:data)
                DispatchQueue.main.async {
                    simpleHapticSuccess()
                    self.catalog = fetched_catalog
                    self.currRotationEndTime = Date(timeIntervalSince1970: (self.catalog?.ranked![0].end_time)!)
                    self.loadingStatus = .loaded
                }
                return
            }
            catch {
                // JSON parsing error
                dump("[load error] Failed to decode: \(error)")
                DispatchQueue.main.async {
                    simpleHapticError()
                    self.loadingStatus = .failure
                }
                return
            }
        }
        
        dataTask.resume()
    }
    
    // MARK: - Start Auto Refreshing
    var tempCatalog: RotationCatalog? = nil
    var isGetTempCatalogDone = false

    // func: auto refresh
    func startAutoRefresh() {
        
//        dump("starts auto-refresh")
        var repeatCounter = 0
        let maxAttempt = 16
        
        DispatchQueue.main.async {
            self.loadingStatus = .duringAutoRefresh
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            
            // Check if attempt maxed out; increment counter
            if repeatCounter >= maxAttempt {
                
                if self.loadingStatus != .duringAutoRefresh {   // if interrupted: quit
                    timer.invalidate()
                    return
                }
                else {                                          // if not interrupted: max attempt; back to normal and stop
                    dump("[auto error] Attempts maxed out: no new data from server for a while")
                    DispatchQueue.main.async {
                        self.loadingStatus = .failure
                    }
                    timer.invalidate()
                    return
                }
                
            }
            else {
                repeatCounter += 1
            }
            
            // fetch temp catalog data
            self.getRotationCatalog()
            while !self.isGetTempCatalogDone {} // wait until temp catalog fetched
            
            // error from helper
            guard let currCatalog = self.tempCatalog else {
                dump("[auto error] Failure from helper")
                if self.loadingStatus != .duringAutoRefresh {   // if interrupted: quit
                    dump("[auto error] Manually interrupted")
                    timer.invalidate()
                    return
                } else {                                        // if not interrupted: set to failure and quit
                    simpleHapticError()
                    self.loadingStatus = .failure
                    timer.invalidate()
                    return
                }
            }
            
            // check new catalog data
            let gotCurrentEndTime = Date(timeIntervalSince1970: currCatalog.ranked![0].end_time)
            if gotCurrentEndTime == self.currRotationEndTime {
                
                // same data: not refresh
                if self.loadingStatus != .duringAutoRefresh {   // if interrupted: quit
                    dump("[auto error] Manually interrupted")
                    timer.invalidate()
                    return
                } else {                                        // if not interrrupted: try again next timer
                    return
                }
            } else {
                
                
                if self.loadingStatus != .duringAutoRefresh {   // if interrupted: quit
                    dump("[auto error] Manually interrupted")
                    timer.invalidate()
                    return
                } else {                                        // if not interrrupted: update and quit
                    DispatchQueue.main.async {
                        self.loadingStatus = .loading
                        simpleHapticSuccess()
                        self.catalog = currCatalog
                        self.currRotationEndTime = Date(timeIntervalSince1970: currCatalog.ranked![0].end_time)
                        self.loadingStatus = .loaded
                    }
                    timer.invalidate()
                    return
                }
            }
        }
    }
    
    // MARK: helper for auto refresh
    func getRotationCatalog() {
        
        self.isGetTempCatalogDone = false
        
        guard let url = URL(string: Constants.ROTATIONS_URL) else {
            dump("[auto helper error] URL invalid")
            self.tempCatalog = nil
            self.isGetTempCatalogDone = true
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // <- optional: handle dataTask err and response
            
            // data fetched
            guard let data = data else {
                dump("[auto helper error] Empty data fetched - connection failed?")
                self.tempCatalog = nil
                self.isGetTempCatalogDone = true
                return
            }
            
            do {
                let fetched_catalog = try JSONDecoder().decode(RotationCatalog.self, from:data)
                self.tempCatalog = fetched_catalog
                self.isGetTempCatalogDone = true
                return
            }
            catch {
                dump("[auto helper error] Failed to decode: \(error)")
                self.tempCatalog = nil
                self.isGetTempCatalogDone = true
                return
            }
        }
        
        dataTask.resume()
    }
}
