//
//  DetailViewController.swift
//  TableOfElements
//
//  Created by Lance Matysik on 3/2/16.
//  Copyright © 2016 Lance Matysik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var recieved : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.font = UIFont(name: "Helvetica Neue", size: 20)
        textView.text = recieved
    }
    
}