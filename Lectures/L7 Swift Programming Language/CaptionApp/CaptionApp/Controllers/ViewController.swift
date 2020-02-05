//
//  ViewController.swift
//  CaptionApp
//
//  Created by Rebecca  Slatkin on 1/27/20.
//  Copyright © 2020 Syracuse University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// The image view that displays the image
    @IBOutlet weak var imageView: UIImageView!
    
    /// The label that displays the caption text
    @IBOutlet weak var captionLabel: UILabel!
    
    var images: [Photo] = []
    var captions: [Caption] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initalize()
        generate()
    }
    
    func initalize() {
        populateImages()
        populateCaptions()
    }
    
    func populateImages(){
        images = [Photo(name: "BearHiding"),
                  Photo(name: "BrownBear"),
                  Photo(name: "Fish"),
                  Photo(name: "LaughingSeal"),
                  Photo(name: "Otters"),
                  Photo(name: "Owls"),
                  Photo(name: "Penguin"),
                  Photo(name: "SeaOtter"),
                  Photo(name: "BearHiding"),
                  Photo(name: "BrownBear"),
                  Photo(name: "Fish"),
                  Photo(name: "LaughingSeal"),
                  Photo(name: "Otters"),
                  Photo(name: "Owls"),
                  Photo(name: "Penguin"),
                  Photo(name: "SeaOtter"),
                  Photo(name: "BearHiding"),
                  Photo(name: "BrownBear"),
                  Photo(name: "Fish"),
                  Photo(name: "LaughingSeal"),
                  Photo(name: "Otters"),
                  Photo(name: "Owls"),
                  Photo(name: "Penguin"),
                  Photo(name: "SeaOtter"),
                  Photo(name: "BearHiding"),
                  Photo(name: "BrownBear"),
                  Photo(name: "Fish"),
                  Photo(name: "LaughingSeal"),
                  Photo(name: "Otters"),
                  Photo(name: "Owls"),
                  Photo(name: "Penguin"),
                  Photo(name: "SeaOtter"),
                  Photo(name: "BearHiding"),
                  Photo(name: "BrownBear"),
                  Photo(name: "Fish"),
                  Photo(name: "LaughingSeal"),
                  Photo(name: "Otters"),
                  Photo(name: "Owls"),
                  Photo(name: "Penguin"),
                  Photo(name: "SeaOtter"),
                  Photo(name: "BearHiding"),
                  Photo(name: "BrownBear"),
                  Photo(name: "Fish"),
                  Photo(name: "LaughingSeal"),
                  Photo(name: "Otters"),
                  Photo(name: "Owls"),
                  Photo(name: "Penguin"),
                  Photo(name: "SeaOtter"),
                  Photo(name: "BearHiding"),
                  Photo(name: "BrownBear"),
                  Photo(name: "Fish"),
                  Photo(name: "LaughingSeal"),
                  Photo(name: "Otters"),
                  Photo(name: "Owls"),
                  Photo(name: "Penguin"),
                  Photo(name: "SeaOtter")]
    }
    
    func populateCaptions() {
        // Import quotes from local JSON file
        let fileName = "theoffice"
        do {
            let captions = try LocalJsonService.readJSON(from: fileName)
            print("captions count: \(captions.count)")
        } catch let error as NSError {
            print("Failed to \(error.localizedDescription)")
        }
    }
    
    func generate() {
        // Fetch random image
        imageView.image = randomImage()
        
        // fetch random caption
        captionLabel.text = randomCaption()
    }
    
    func randomImage() -> UIImage {
        guard let imageInfo = images.randomElement(), let image = UIImage(named: imageInfo.name) else {
            assertionFailure("Image info should be available")
            return UIImage()
        }
        return image
    }
    
    @IBAction func handleDidTapCamera(_ sender: Any) {
        // Show Image Picker
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .camera
    }
    
    func randomCaption() -> String {
        guard let caption = captions.randomElement() else {
            assertionFailure("Caption should not be nil")
            return ""
        }
        return caption.quote
    }
    
    @IBAction func handleRefreshAction(_ sender: Any) {
        generate()
    }
}

