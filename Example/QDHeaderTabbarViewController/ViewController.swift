//
//  ViewController.swift
//  QDHeaderTabbarViewController
//
//  Created by 244514311@qq.com on 11/10/2018.
//  Copyright (c) 2018 244514311@qq.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "style1.jpg")
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

