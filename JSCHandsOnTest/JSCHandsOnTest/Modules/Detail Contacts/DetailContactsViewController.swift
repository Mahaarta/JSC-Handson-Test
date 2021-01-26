//
//  DetailContactsViewController.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit

class DetailContactsViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    //
    var selectedContacts: SelectedContacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataMartImage = URL(string: selectedContacts?.profile_thumbnail ?? "") {
            profileImage.contentMode = .scaleAspectFill
            profileImage.kf.setImage(with: dataMartImage)
        } else {
            profileImage.image = UIImage(named: "image-default")
            profileImage.contentMode = .scaleAspectFit
        }
        
        nameLabel.text = "\(selectedContacts?.name_first ?? "") \(selectedContacts?.name_last ?? "")"
        pobLabel.text = "\(selectedContacts?.dob_date ?? "")"
        
        genderLabel.text = "\(selectedContacts?.gender ?? "")"
        emailLabel.text = "\(selectedContacts?.email ?? "")"
        cellLabel.text = selectedContacts?.cell ?? ""
        
    }
    
    // MARK: BUTTON ACTION
    @IBAction func deleteButton_tapped(_ sender: Any) {
        
    }
}
