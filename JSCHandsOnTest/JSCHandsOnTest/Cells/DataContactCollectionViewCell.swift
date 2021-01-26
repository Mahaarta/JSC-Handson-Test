//
//  DataContactCollectionViewCell.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit

class DataContactCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.cornerRadius = profileImage.height / 2
    }
    
    var dataContact: DataContact? {
        didSet {
            guard let dataContact = dataContact else { return }
            if let dataMartImage = URL(string: dataContact.picture_thumbnail) {
                profileImage.contentMode = .scaleAspectFill
                profileImage.kf.setImage(with: dataMartImage)
            } else {
                profileImage.image = UIImage(named: "image-default")
                profileImage.contentMode = .scaleAspectFit
            }
            
            nameLabel.text = "\(dataContact.name_first) \(dataContact.name_last)"
        }
    }
    
    var selectedContacts: SelectedContacts? {
        didSet {
            guard let selectedContacts = selectedContacts else { return }
            if let dataMartImage = URL(string: selectedContacts.profile_thumbnail) {
                profileImage.contentMode = .scaleAspectFill
                profileImage.kf.setImage(with: dataMartImage)
            } else {
                profileImage.image = UIImage(named: "image-default")
                profileImage.contentMode = .scaleAspectFit
            }
            
            nameLabel.text = "\(selectedContacts.name_first) \(selectedContacts.name_last)"
        }
    }

}
