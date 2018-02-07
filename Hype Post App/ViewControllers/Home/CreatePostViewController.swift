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
        //TODO: Implement post

        DBService.manager.newPost(header: postTitle.text!, body: postBody.text!, image: userImage.image ?? nil)
        
        let alertController = UIAlertController(title: "Success!", message: "post sucessful!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.dismiss(animated: true, completion: {self.resignFirstResponder()})
            self.resignFirstResponder()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)

     
       // DBService.manager.newPost(header: postTitle.text!, body: postBody.text!, by: AuthUserService.getCurrentUser()?.displayName ?? "N/A")

    }

    
    var configuration = Configuration()
    var imagePickerController: ImagePickerController!
    
    
    override func viewDidLoad() {
        configuration.bottomContainerColor = Color.grey.lighten5
        configuration.backgroundColor = .green
        configuration.gallerySeparatorColor = .blue
        configuration.mainColor = .red
        configuration.settingsColor = .magenta
        configuration.collapseCollectionViewWhileShot = true
        
        imagePickerController = ImagePickerController(configuration: configuration)
        super.viewDidLoad()
        postBody.borderColor = UIColor.gray
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1

    }
    
    public static func storyboardInstance() -> CreatePostViewController {
        let storyboard = UIStoryboard(name: "CreatePost", bundle: nil)
        let createPostVC = storyboard.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        return createPostVC
    }
    
    @IBAction func openCamera(_ sender: UIBarButtonItem) {
        

        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    
    private let imagePickerViewController = UIImagePickerController()

}

extension CreatePostViewController: ImagePickerDelegate{
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        return
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        return
        
    }
    
}
