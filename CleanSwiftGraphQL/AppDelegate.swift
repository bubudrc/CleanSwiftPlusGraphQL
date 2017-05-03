//
//  AppDelegate.swift
//  CleanSwiftGraphQL
//
//  Created by Marcelo Perretta on 5/2/17.
//  Copyright © 2017 Marcelo Perretta. All rights reserved.
//

import UIKit
import Apollo

// Change localhost to your machine's local IP address when running from a device
let apollo = ApolloClient(url: URL(string: "http://localhost:8080/graphql")!)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print()
        apollo.cacheKeyForObject = { $0["id"] }
        return true
    }
}

