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
        SWCharacter.getCharacters { (characters, error) in
            print(characters)
            SWCharacter.getCharacters(completion: { (sameCharacters, newError) in
                print(sameCharacters)
            })
        }
    }
}

