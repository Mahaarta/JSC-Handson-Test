//
//  HomeViewController.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit
import PKHUD

class HomeViewController: UIViewController, ModalViewControllerDelegate {
    
    @IBOutlet weak var colView: UICollectionView!
    // Data Contact
    var dataContactRequest = DataContactRequest()
    var dataContact: DataContact?
    var dataContactList: DataContactList?
    var arrDataContact: [DataContact]?
    // selected contacts
    var selectedContacts: [SelectedContacts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kelola Kontak"
        self.tabBarController?.tabBar.isHidden = true
        
        DataContactCollectionViewCell.register(for: colView)
        plusIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        print("123123123123dasduyastf \(selectedContacts.first?.name_first ?? "")")
    }
    
    func sendValue(selectedContacts: [SelectedContacts]) {
        dismiss(animated: true, completion: nil)
        self.selectedContacts = selectedContacts
        colView.reloadData()
        print("sendValue data \(selectedContacts.count)")
    }
    
    func plusIcon() {
        let plusButton = UIButton(type: .custom)
        plusButton.setImage(UIImage(named: "icon-white-plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusIconButton_tapped), for: .touchUpInside)
        plusButton.frame = CGRect(x: -30, y: 0, width: 40, height: 40)
        let barButton = UIBarButtonItem(customView: plusButton)
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    // MARK: BUTTON ACTION
    @IBAction func plusIconButton_tapped(_ sender: Any) {
        let vc = AddContactViewController.loadFromNib()
        vc.selectedContacts = self.selectedContacts
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        self.present(vc, animated: true, completion: nil)
        hidesBottomBarWhenPushed = false
    }
}

// MARK: Data Contact Request Delegate
extension HomeViewController: DataContactRequestDelegate {
    func DataContactRequestSuccess(_ dataContactList: DataContactList) {
        HUD.hide()
        self.dataContactList = dataContactList
    }
    
    func DataContactRequestFailed(_ message: String) {
        HUD.hide()
        showAlert(title: Constants.defaultErrorTitle, message: message)
    }
}


// MARK: COLLECTION SETTING
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("askdj123123uytsad \(selectedContacts.count)")
        return self.selectedContacts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DataContactCollectionViewCell.self), for: indexPath) as! DataContactCollectionViewCell
        
        cell.selectedContacts = self.selectedContacts[safe: indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let approximateWidthOfBioTextView = view.frame.width
        
        return CGSize(width: approximateWidthOfBioTextView, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailContactsViewController.loadFromNib()
        vc.selectedContacts = selectedContacts[safe: indexPath.item]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc)
        hidesBottomBarWhenPushed = true
    }
}
