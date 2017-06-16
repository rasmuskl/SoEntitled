//
//  Constants.swift
//  SoEntitled
//
//  Created by Chris Fuentes on 5/23/17.
//  Copyright © 2017 microsoft. All rights reserved.
//

import Foundation

struct K {
    static let APP_GROUP_ID : String = "group.so.entitled"
    static let APP_KEY : String = "app key"
    static let WATCH_KEY : String = "watch key"
    static let TODAY_KEY : String = "today key"
    static let VALUE : String = "Hi!"
    static let ERR_MSG : String = "App Groups Not Working"
    static let DEFAULT_MSG : String = "No Data"

    static func sharedContainer() -> UserDefaults {
        return UserDefaults(suiteName: K.APP_GROUP_ID)!
    }
}
