//
//  ViewController.swift
//  AWSS3Upload
//
//  Created by Raghvendra on 08/12/16.
//  Copyright © 2016 OneCorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        sendFile(imageName: "8481-4",image:UIImage(named:"8481-4")!, extention: "jpg", S3BucketName: "bd-bucket-1")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

