//
//  ProfileListViewController.swift
//  FetchAndViewProfiles
//
//  Created by Eric Ludlow on 4/5/18.
//  Copyright © 2018 EricLudlow. All rights reserved.
//

import UIKit

class ProfileListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var characters: [SWCharacter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "The Stars"
        
        SWCharacter.getCharacters { (characters, error) in
            guard let characters = characters, error == nil else {
                //TODO:- handle errors
                return
            }
            
            self.characters = characters
            self.tableView?.reloadData()
        }
    }
}

extension ProfileListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        let character = characters[indexPath.row]
        cell.character = character
        return cell
    }
}
