//
//  SecondViewController.swift

import UIKit
import CoreLocation
import HealthKit

class SecondViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!

    @IBOutlet var label: UILabel!

    var zeroTime = TimeInterval()
    var timer : Timer = Timer()

    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distanceTraveled = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        getHealthKitPermission()
    }


    func getHealthKitPermission() {

        // Seek authorization in HealthKitManager.swift.
        authorizeHealthKit { (authorized,  error) -> Void in
            DispatchQueue.main.async {
                if authorized {
                    // Get and set the user's height.
                    self.label.text = "Permission Granted"
                } else {
                    if error != nil {
                        if ((error! as NSError).domain == "com.apple.healthkit" &&
                            (error! as NSError).code == 4) {
                            self.label.text = "Missing Entitlement"
                        } else {
                            self.label.text = (error! as NSError).description
                        }
                    } else {
                        self.label.text = "Permission Denied"
                    }
                }
            }
        }
    }

    func authorizeHealthKit(completion: ((_ success: Bool, _ error: Error?) -> Void)!) {

        // State the health data type(s) we want to read from HealthKit.
        let healthDataToRead = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!)

        // State the health data type(s) we want to write from HealthKit.
        let healthDataToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier:HKQuantityTypeIdentifier.distanceWalkingRunning)!)

        // Just in case OneHourWalker makes its way to an iPad...
        if !HKHealthStore.isHealthDataAvailable() {
            print("Can't access HealthKit.")
        }

        // Request authorization to read and/or write the specific data.
        HKHealthStore().requestAuthorization(toShare: healthDataToWrite,
                                             read: healthDataToRead) { (success, error) -> Void in
            if (completion != nil) {
                completion(success, error)
            }
        }
    }
}
