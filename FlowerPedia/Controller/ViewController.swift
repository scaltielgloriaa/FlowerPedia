//
//  ViewController.swift
//  FlowerPedia
//
//  Created by Scaltiel Gloria on 28/04/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    var player: AVAudioPlayer!
    
    @IBOutlet weak var imageView: UIImageView!
    var imageNames = ["1","2","3","4","5","6","7","8","9","10","11"]
    var images = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9490196078, green: 0.9137254902, blue: 0.7921568627, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        for i in 0..<imageNames.count{
            images.append(UIImage(named: imageNames[i])!)
        }
        imageView.animationImages = images
        imageView.animationDuration = 4.0
        imageView.startAnimating()
        playSound(name: "magic")
    }
    

    func playSound(name: String) {
       
        let url = Bundle.main.url(forResource: name, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
}

