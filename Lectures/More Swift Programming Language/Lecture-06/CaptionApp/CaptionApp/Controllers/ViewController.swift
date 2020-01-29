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
    
    var pictures: [Photo] = []
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
        pictures = [Photo(name: "BearHiding"),
                        Photo(name: "BrownBear"),
                        Photo(name: "Fish"),
                        Photo(name: "LaughingSeal"),
                        Photo(name: "Otters"),
                        Photo(name: "Owls"),
                        Photo(name: "Penguin"),
                        Photo(name: "SeaOtter")]
    }
    
    func populateCaptions() {
        captions = [Caption(text: "I am serious. And don't call me Shirley"),
                          Caption(text: "I'm about to do to you what Limp Bizkit did to music in the late '90s."),
                          Caption(text: "I'm in a glass case of emotion!"),
                          Caption(text: "I'll have what she's having."),
                          Caption(text: "Nothing to see here, move along")]
    }
    
    
    func generate() {
        // Fetch random image
        imageView.image = randomImage()
        
        // fetch random caption
        captionLabel.text = randomCaption()
    }
    
    func randomImage() -> UIImage {
        let picture = pictures.randomElement()
        
        guard let imageInfo = pictures.randomElement(), let image = UIImage(named: imageInfo.name) else {
            assertionFailure("Image info should be available")
            return UIImage()
        }
        return image
    }
    
    func randomCaption() -> String {
        guard let caption = captions.randomElement() else {
            assertionFailure("Caption should not be nil")
            return ""
        }
        return caption.text
    }
    
    @IBAction func handleRefreshAction(_ sender: Any) {
        generate()
    }
}

