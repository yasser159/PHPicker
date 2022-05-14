//
//  ViewController.swift
//  PHPicker
//
//  Created by Yasser Hajlaoui on 5/12/22.
//

import Photos
import PhotosUI
import UIKit

class ViewController: UIViewController, PHPickerViewControllerDelegate {

    
    @IBOutlet weak var img_imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Photo Picker"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
            action: #selector(didTapAdd))
    }

    @objc private func didTapAdd() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else{
                    return
                }

                DispatchQueue.main.async {
                    self.img_imageView.image = image
                    }
            }
        }
    }
}

