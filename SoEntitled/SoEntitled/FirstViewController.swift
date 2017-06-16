//
//  FirstViewController.swift
//  SoEntitled
//
//  Created by Chris Fuentes on 5/23/17.
//  Copyright © 2017 microsoft. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var resultsLabel: UILabel!
    @IBOutlet var watchResultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter().addObserver(self,
                                         selector: #selector(FirstViewController.notified),
                                         name: UserDefaults.didChangeNotification,
                                         object: nil)

        let ctr = UserDefaults(suiteName: K.APP_GROUP_ID)
        ctr?.set(K.VALUE, forKey: K.APP_KEY)
        ctr?.synchronize()

        updateLabel()
    }

    override func viewDidAppear(_ animated: Bool) {
        updateLabel()
    }

    func updateLabel() {
        resultsLabel.text = "Today: " + (K.sharedContainer().value(forKey: K.TODAY_KEY) as? String ?? K.DEFAULT_MSG)
        watchResultsLabel.text = "Watch: " + (K.sharedContainer().value(forKey: K.WATCH_KEY) as? String ?? K.DEFAULT_MSG)
    }

    func notified() {
        updateLabel()
    }
}

