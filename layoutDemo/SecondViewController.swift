//
//  SecondViewController.swift
//  layoutDemo
//
//  Created by Valerie Farber on 1/11/18.
//  Copyright © 2018 Valerie Farber. All rights reserved.
//

import UIKit
import CoreMotion
import AVKit


class SecondViewController: UIViewController {
    
    @IBOutlet var fortuneMessageLabel: UILabel!
    
    //Declare motionManager as optional CMMotionManager
    var motionManager: CMMotionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assigning instance of MotionManager to variable
        motionManager = CMMotionManager()
        //Safely unwrapping and accessing manager
        
        
        if let manager = motionManager {
            print("We have our manager")
            //Establish alternate Queueueueue to handle updates
            let myQ = OperationQueue()
            
            // set updateInterval
            
            manager.deviceMotionUpdateInterval = 0.25
            //Call method to start updates, sending in myQ and closure to handle data
            
            manager.startDeviceMotionUpdates(to: myQ, withHandler: {
                
                (data: CMDeviceMotion?, error: Error?) in
                //Safely unwrapping data or error
                if let myData = data {
//                    let attitude = myData.attitude
                    let acceleration = myData.userAcceleration
                    let xAcc = acceleration.x

//                    print("X: \(xAcc), Y: \(yAcc), Z: \(zAcc)")
                    if xAcc > 0.90 {
                        self.motionManager?.stopAccelerometerUpdates()
//                        print("\nWe are Shaking! pitch: \(pitch) yaw: \(yaw) roll: \(roll)")
                        let message = self.tellFortune()
                        
                        
                        print(message)
                        
                        DispatchQueue.main.async {
                         self.fortuneMessageLabel.text = message;
                        
                        
                        }
                    self.motionManager?.stopAccelerometerUpdates()
                    }
//
                    
                } // end of if myData = data
                //Safely unwrapping errors
                if let myError = error {
                    print("error",myError)
                }
            }) // end of handler
        } // enf of if manager = motionManager
        else {
            print("We have no manager")
        }
    } // end of override fun viewDidLoad()
    
    func getDegrees(radians: Double) -> Double {
        return 180 / Double.pi * radians
    }
    
    func tellFortune () -> String {
        let fortune = Int(arc4random_uniform(5))
        var str = ""
        if fortune == 0
        {
            str += "No"
        }
        if fortune == 1 {
            str += "Yes"
        }
        if fortune == 2 {
            str += "It could be."
        }
        if fortune == 3 {
            str += "Most likely."
        }
        if fortune == 4 {
            str += "Not likely."
        }
        if fortune == 5 {
            str += "Yes!"
        }
        return str
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
