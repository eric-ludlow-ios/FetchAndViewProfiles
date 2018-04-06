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
    
    @IBOutlet weak var insetView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    
    var character: SWCharacter? {
        didSet {
            guard let character = character else { return }
            
            profileImageView.kf.setImage(with: character.profilePictureUrl)
            nameLabel.text = character.fullName
            affiliationLabel.text = character.affiliation?.title
            setNeedsDisplay()
        }
    }
    
    private var cornerRadius: CGFloat = 5.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        insetView.layer.borderColor = UIColor.white.cgColor
        insetView.layer.borderWidth = 3.0
        insetView.layer.cornerRadius = cornerRadius
        
        let bounds = insetView.bounds
        let rect = CGRect(x: bounds.origin.x - 2.0, y: bounds.origin.y, width: bounds.width + 4.0, height: bounds.height - 2.0)
        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        insetView.layer.shadowPath = shadowPath
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let character = character else { return }
        
        insetView.layer.shadowColor = character.affiliation?.color
        insetView.layer.shadowOpacity = 0.8
        insetView.layer.shadowRadius = 5.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        insetView.layer.shadowColor = nil
        insetView.layer.shadowOpacity = 0.0
        insetView.layer.shadowRadius = 0.0
    }
}
