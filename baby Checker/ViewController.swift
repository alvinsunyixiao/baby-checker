//
//  ViewController.swift
//  baby Checker
//
//  Created by Yixiao Sun on 4/13/16.
//  Copyright © 2016 Yixiao Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myView: UIImageView!
    var gettingPic = false
    var myTrans: transmitter = transmitter(host: "127.0.0.1", port: 13500)
    
    @IBAction func classify(sender: UIButton) {
        let label = sender.tag
    }
    
    @IBAction func getpic(sender: UIButton) {
        if gettingPic {
            return
        }
        gettingPic = true
        let raw_data = myTrans.requireDataWithCommand(["getpic"])
        let nsdata = NSData(bytes: raw_data, length: raw_data.count)
        let myImg = UIImage(data: nsdata)
        myView.image = myImg
        gettingPic = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

