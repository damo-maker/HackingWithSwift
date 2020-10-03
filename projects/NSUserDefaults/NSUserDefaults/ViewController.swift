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
        
        title = "Names to Images"
        
        let defaults = UserDefaults.standard
        
        if let savedImages = defaults.object(forKey: "images") as? Data {
            images = NSKeyedUnarchiver.unarchiveObject(with: savedImages) as! [NewImage]
        }
        
        
       navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.addImageCell))
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
        
        let path = getDocumentsDirectory().appending(newimage.image)
        cell.imageView.image = UIImage(contentsOfFile: path)
        
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
            
            self.save()
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
        var newImage: UIImage
        
    if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
        newImage = possibleImage
    } else if let possibleImage = info["UIImageImagePickerControllerOriginalImage"] as? UIImage {
        newImage = possibleImage
    } else {
        return
    }
        
    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appending(imageName)
    let jpegData = UIImageJPEGRepresentation(newImage, 80)
   try? jpegData?.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
        
    let newimage = NewImage(name: "unknown", image: imageName)
    images.append(newimage)
        
    collectionView.reloadData()
        
    save()
        
   dismiss(animated: true, completion: nil)
  }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true) as [NSString]
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func save() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: images)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "images")
    }
    
}






















