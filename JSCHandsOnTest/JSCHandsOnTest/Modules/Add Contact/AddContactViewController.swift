//
//  AddContactViewController.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit
import PKHUD

protocol ModalViewControllerDelegate {
    func sendValue(selectedContacts : [SelectedContacts])
}

class AddContactViewController: UIViewController {

    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var colView: UICollectionView!
    // Data Contact
    var dataContactRequest = DataContactRequest()
    var dataContact: DataContact?
    var dataContactList: DataContactList?
    var arrDataContact: [DataContact]?
    // Selected Contact
    var selectedContacts: [SelectedContacts] = []
    //
    var delegate: ModalViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pilih Kontak"
        DataContactCollectionViewCell.register(for: colView)
        
        retrieveContactData()
        closeIcon()
        
        print("asdsad \(selectedContacts.count)")
    }
    
    func closeIcon() {
        let close = UIButton(type: .custom)
        close.setImage(UIImage(named: "icon-white-close"), for: .normal)
        close.addTarget(self, action: #selector(closeButton_tapped), for: .touchUpInside)
        close.frame = CGRect(x: -30, y: 0, width: 40, height: 40)
        let barButton = UIBarButtonItem(customView: close)
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func retrieveContactData() {
        dataContactRequest.prepare(requestHandler: self)
        dataContactRequest.start()
    }
    
    // MARK: BUTTON ACTION
    @IBAction func closeButton_tapped(_ sender: Any) {
        let vc = HomeViewController.loadFromNib()
        vc.selectedContacts = self.selectedContacts
        navigationController?.popToViewController(vc, animated: true)
    }
    
}

// MARK: Data Contact Request Delegate
extension AddContactViewController: DataContactRequestDelegate {
    func DataContactRequestSuccess(_ dataContactList: DataContactList) {
        HUD.hide()
        self.dataContactList = dataContactList
        colView.reloadData()
    }
    
    func DataContactRequestFailed(_ message: String) {
        HUD.hide()
        showAlert(title: Constants.defaultErrorTitle, message: message)
    }
}


// MARK: COLLECTION SETTING
extension AddContactViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataContactList?.arrDataContact.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DataContactCollectionViewCell.self), for: indexPath) as! DataContactCollectionViewCell
        
        cell.dataContact = self.dataContactList?.arrDataContact[safe: indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let approximateWidthOfBioTextView = view.frame.width
        
        return CGSize(width: approximateWidthOfBioTextView, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected_contact = self.dataContactList?.arrDataContact[safe: indexPath.item]
        
        selectedContacts.append(
            SelectedContacts(
                gender: selected_contact?.gender ?? "",
                name_title: selected_contact?.name_title ?? "",
                name_first: selected_contact?.name_first ?? "",
                name_last: selected_contact?.name_last ?? "",
                location_street_number: selected_contact?.location_street_number ?? 0,
                location_street_name: selected_contact?.location_street_name ?? "",
                location_city: selected_contact?.location_city ?? "",
                location_state: selected_contact?.location_state ?? "",
                location_country: selected_contact?.location_country ?? "",
                profile_thumbnail: selected_contact?.picture_thumbnail ?? "",
                email: selected_contact?.email ?? "",
                cell: selected_contact?.cell ?? "",
                phone: selected_contact?.cell ?? ""
            )
        )
        
        print("asdoiuytr7890- \(selectedContacts.count)")
        delegate.sendValue(selectedContacts: selectedContacts)
    }
}
