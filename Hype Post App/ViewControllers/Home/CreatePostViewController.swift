//
//  CreatePostViewController.swift
//  Hype Post App
//
//  Created by C4Q on 2/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import ImagePicker
import Material

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postBody: UITextField!
    
    @IBAction func openGallary(_ sender: UIBarButtonItem) {
        
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let currentUserDisplayName = AuthUserService.getCurrentUser()?.displayName {
        DBService.manager.newPost(header: postTitle.text!, body: postBody.text!, image: imageView.image ?? nil, byUser: currentUserDisplayName)
        }
        let alertController = UIAlertController(title: "Success!", message: "post sucessful!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.dismiss(animated: true, completion: {self.resignFirstResponder()})
            self.resignFirstResponder()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)

     
       // DBService.manager.newPost(header: postTitle.text!, body: postBody.text!, by: AuthUserService.getCurrentUser()?.displayName ?? "N/A")

    }
    var images = [UIImage]() {
        didSet {
            imageView.image = images.first
        }
    }
    
    var imagePickerController: ImagePickerController!
    
    override func viewDidLoad() {
        imagePickerController = ImagePickerController()
        super.viewDidLoad()
        postBody.borderColor = UIColor.gray
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1

        imageView.clipsToBounds = true
    }
    
    public static func storyboardInstance() -> CreatePostViewController {
        let storyboard = UIStoryboard(name: "CreatePost", bundle: nil)
        let createPostVC = storyboard.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        return createPostVC
    }
    
    @IBAction func openCamera(_ sender: UIBarButtonItem) {
        self.images = []
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }
    
    private let imagePickerViewController = UIImagePickerController()
}

extension CreatePostViewController: ImagePickerDelegate{
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = images
        dismiss(animated: true, completion: nil)
        return
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.resetAssets()
        return
    }
}
