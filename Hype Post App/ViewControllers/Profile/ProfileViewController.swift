//
//  ProfileViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import HMSegmentedControl
import SnapKit

class ProfileViewController: UITableViewController {
    
    var posts = [Post]()
    
    //Profile Info View Stuff
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userDescription: UITextView!
//    @IBOutlet weak var container: UIView!
    
    @IBAction func tempLogoutButton(_ sender: UIButton) {
        logout()
    }
    
    @IBAction func editProfile(_ sender: UIButton) {
        let profileVC = ProfileViewController()
        present(profileVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    /***********************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func loadData() {
        DBService.manager.getAllPosts { (posts) in
            self.posts = posts
        }
    }

    public static func storyboardInstance() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        return profileViewController
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(UserActivityCollectionViewCell.self, forCellWithReuseIdentifier: "ActivityCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
//
    fileprivate func logout() {
        FirebaseAPIClient.manager.logOutCurrentUser()
        self.dismiss(animated: true, completion: {
            self.present(EntryViewController.storyboardINstance(), animated: true)
        })
    }
}
//MARK: - CollectionView Methods
extension ProfileViewController: UICollectionViewDelegate {

}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCell", for: indexPath) as! UserActivityCollectionViewCell
        let colors: [UIColor] = [.yellow, .blue]
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}


