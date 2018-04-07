//
//  ProfileDetailViewController.swift
//  FetchAndViewProfiles
//
//  Created by Eric Ludlow on 4/6/18.
//  Copyright © 2018 EricLudlow. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var affiliationLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var character: SWCharacter?
    
    private let cornerRadius: CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        title = character?.fullName
        
        setUpViews()
        setUpContent()
    }
    
    private func setUpViews() {
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.cornerRadius = cornerRadius
        profileImageView.layer.masksToBounds = true
        
        let bounds = shadowView.bounds
        // more magic numbers  :(
        let rect = CGRect(x: bounds.origin.x - 4.0, y: bounds.origin.y - 2.0, width: bounds.width + 10.0, height: bounds.height + 11.0)
        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        shadowView.layer.shadowPath = shadowPath
        
        shadowView.layer.shadowColor = character?.affiliation?.color
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 5.0
    }
    
    private func setUpContent() {
        guard let character = character else { return }
        
        profileImageView.kf.setImage(with: character.profilePictureUrl)
        var affiliationText = character.forceUser
        
        if let title = character.affiliation?.title {
            affiliationText = title + " - " + affiliationText
        }
        
        affiliationLabel.text = affiliationText
        
        let age = character.age
        let punctuation = age > 80 ? "!" : "."
        ageLabel.text = "Age: \(age) years old" + punctuation
    }
}
