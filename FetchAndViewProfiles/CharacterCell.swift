//
//  CharacterCell.swift
//  FetchAndViewProfiles
//
//  Created by Eric Ludlow on 4/6/18.
//  Copyright © 2018 EricLudlow. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var insetView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    
    var character: SWCharacter? {
        didSet {
            guard let character = character else { return }
            
            profileImageView.kf.setImage(with: character.profilePictureUrl, placeholder: UIImage(named: "r2d2"), options: nil, progressBlock: nil, completionHandler: nil)
            nameLabel.text = character.fullName
            affiliationLabel.text = character.affiliation?.title
            setNeedsDisplay()
        }
    }
    
    private let cornerRadius: CGFloat = 5.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundImageView.layer.borderColor = UIColor.white.cgColor
        backgroundImageView.layer.borderWidth = 3.0
        backgroundImageView.layer.cornerRadius = cornerRadius
        backgroundImageView.layer.masksToBounds = true
        
        let bounds = shadowView.bounds
        // magic numbers  :(
        let rect = CGRect(x: bounds.origin.x - 2.0, y: bounds.origin.y, width: bounds.width + 4.0, height: bounds.height + 5.0)
        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        shadowView.layer.shadowPath = shadowPath
        
        profileImageView.layer.cornerRadius = cornerRadius
        profileImageView.layer.masksToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let character = character else { return }
        
        shadowView.layer.shadowColor = character.affiliation?.color
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 5.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.kf.cancelDownloadTask()
        nameLabel.text = nil
        affiliationLabel.text = nil
        
        shadowView.layer.shadowColor = nil
        shadowView.layer.shadowOpacity = 0.0
        shadowView.layer.shadowRadius = 0.0
    }
}
