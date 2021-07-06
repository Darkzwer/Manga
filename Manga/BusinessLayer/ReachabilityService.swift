//
//  ReachabilityService.swift
//  Manga
//
//  Created by Igor on 02/06/2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import Foundation
import Reachability

class ReichabilityService {
    static let shared = ReichabilityService()
    let reachability = try? Reachability()
    var isConnected: Bool
    init () {
        isConnected = reachability?.connection != .unavailable
    }
    deinit {
        stopMonitoring()
    }
    func startMonitoring () {
        guard let rechability = reachability else { return }
        rechability.whenReachable = { [weak self ] _ in
            self?.isConnected = true
        }
        rechability.whenUnreachable = { [weak self ] _ in
            print("Not reachable")
            self?.isConnected = false
        }
        do {
            try rechability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    func stopMonitoring() {
        reachability?.stopNotifier()
    }
    func isNetworkConnect () -> Bool {
        return isConnected
    }
}
