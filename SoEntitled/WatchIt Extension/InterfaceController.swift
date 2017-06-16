//
//  InterfaceController.swift
//  WatchIt Extension
//
//  Created by Chris Fuentes on 5/23/17.
//  Copyright © 2017 microsoft. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var todayLabel: WKInterfaceLabel!
    @IBOutlet var label: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        NotificationCenter().addObserver(self,
                                         selector: #selector(InterfaceController.notified),
                                         name: UserDefaults.didChangeNotification,
                                         object: nil)

        let ctr = UserDefaults(suiteName: K.APP_GROUP_ID)
        ctr?.set(K.VALUE, forKey: K.WATCH_KEY)
        ctr?.synchronize()

        updateLabel()
    }

    override func didAppear() {
        updateLabel()
    }
    
    func updateLabel() {
        todayLabel.setText("Today: " + (K.sharedContainer().value(forKey: K.TODAY_KEY) as? String ?? K.DEFAULT_MSG))
        label.setText("App: " + (K.sharedContainer().value(forKey: K.APP_KEY) as? String ?? K.DEFAULT_MSG))
    }

    func notified() {
        updateLabel()
    }
}
