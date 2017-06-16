//
//  TodayViewController.swift
//  HejVerden
//
//  Created by Chris Fuentes on 5/23/17.
//  Copyright © 2017 microsoft. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet var watchLabel: UILabel!
    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.

        NotificationCenter().addObserver(self,
                                         selector: #selector(TodayViewController.notified),
                                         name: UserDefaults.didChangeNotification,
                                         object: nil)

        let ctr = UserDefaults(suiteName: K.APP_GROUP_ID)
        ctr?.set(K.VALUE, forKey: K.TODAY_KEY)
        ctr?.synchronize()

        updateLabel()
    }

    override func viewDidAppear(_ animated: Bool) {
        updateLabel()
    }

    func updateLabel() {
        label.text = "App: " + (K.sharedContainer().value(forKey: K.APP_KEY) as? String ?? K.DEFAULT_MSG)
        watchLabel.text = "Watch: " + (K.sharedContainer().value(forKey: K.WATCH_KEY) as? String ?? K.DEFAULT_MSG)
    }

    func notified() {
        updateLabel()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
