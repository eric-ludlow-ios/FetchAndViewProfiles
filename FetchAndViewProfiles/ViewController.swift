//
//  ViewController.swift
//  FetchAndViewProfiles
//
//  Created by Eric Ludlow on 4/5/18.
//  Copyright © 2018 EricLudlow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SWCharacter.fetchCharacters { (characters, error) in
            print(characters)
        }
    }
}

