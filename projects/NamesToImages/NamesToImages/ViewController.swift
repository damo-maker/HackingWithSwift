//
//  ViewController.swift
//  NamesToImages
//
//  Created by Damian Johns on 1/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [NewImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
       navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImageCell))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        
        let newimage = images[indexPath.item]
        
        cell.name.text = newimage.name
        
        let path = getDocumentsDirectory().appendingPathComponent(newimage.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.item]
        
        let ac = UIAlertController(title: "Rename Image", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
            let newName = ac.textFields![0] as UITextField
            image.name = newName.text!
            self.collectionView.reloadData()
        })
        
        present(ac, animated: true, completion: nil)
    }
 
    func addImageCell() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard var newImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
    if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
        newImage = possibleImage
    } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
        newImage = possibleImage
    } else {
         print("Something went wrong")
         return
    }   
        
        if let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            try? jpegData.write(to: imagePath)
        }
        
    let newimage = NewImage(name: "unknown", image: imageName)
    images.append(newimage)
        
    collectionView.reloadData()
        
    dismiss(animated: true, completion: nil)
  }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
    

    























