//
//  CreatePostViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postBody: UITextField!
    
    @IBAction func openGallary(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func openCamera(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        //TODO: Implement post
        DBService.manager.newPost(header: postTitle.text!, body: postBody.text!, image: userImage.image ?? nil)
        
        let alertController = UIAlertController(title: "Success!", message: "post sucessful!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.dismiss(animated: true, completion: {})
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
     
       // DBService.manager.newPost(header: postTitle.text!, body: postBody.text!, by: AuthUserService.getCurrentUser()?.displayName ?? "N/A")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postBody.borderColor = UIColor.gray
    }
    
    public static func storyboardInstance() -> CreatePostViewController {
        let storyboard = UIStoryboard(name: "CreatePost", bundle: nil)
        let createPostVC = storyboard.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        return createPostVC
    }
    
}
