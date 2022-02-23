//
//  SecondViewController.swift
//  FlowerPedia
//
//  Created by Scaltiel Gloria on 28/04/21.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let URl = "https://en.wikipedia.org/w/api.php"
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var flowerName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shortDesc: UILabel!
    @IBOutlet weak var shortDescView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true,completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // picked the image
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            //converetd into ciimage
            guard let convertedCIImage = CIImage(image: userPickedImage) else{
                fatalError("Convert to CIImage is failed")
            }
            // pasing the image into this detect method
            detect(image: convertedCIImage)
            
            imageView.image = userPickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    func detect(image:CIImage) {
        // detect what flower it is
        // vision container for our model
        
        guard let model = try? VNCoreMLModel(for: FlowersClassifier(()).model) else {
            fatalError("can't import the model")
        }
        // create the request
        let request = VNCoreMLRequest(model: model) { (request, error) in
            // look for where the image are classifier as
            guard let classification = request.results?.first as? VNClassificationObservation else{
                fatalError("Could not classify the image")
            }
            // identifier = is a string that describes what the classification was(what flower it might be)
            self.flowerName.text = classification.identifier.capitalized
            self.shortDescView.layer.shadowColor = UIColor.black.cgColor
            self.shortDescView.layer.shadowOpacity = 0.2
            self.shortDescView.layer.shadowOffset = CGSize.zero
            self.shortDescView.layer.shadowRadius = 5
            self.requestDescription(flowerName: classification.identifier)
        }
        //handler to process that request
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch  {
            print(error)
        }
        
    }

    func requestDescription(flowerName: String) {
        let parameters : [String:String] = [

            "format" : "json",
            "action" : "query",
            "prop" : "extracts",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1"
          ]
        Alamofire.request(URl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess{
                print("Got the wikipedia Info")
                print(response)
                let flowerJSON :JSON = JSON(response.result.value!)
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                print(flowerDescription)
                self.shortDesc.text = flowerDescription

            }
        }

    }

    

}

extension FlowersClassifier {
    convenience init(_ foo: Void) {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }
}
