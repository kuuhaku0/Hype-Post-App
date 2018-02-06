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
        DBService.manager.newPost(header: postTitle.text!, body: postBody.text!, image:nil)
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
