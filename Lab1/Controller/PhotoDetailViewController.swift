//
//  DetailViewController.swift
//  TFeed
//
//  Created by Sanaz Khosravi on 9/9/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet var myImageView: UIImageView!
    var picture: [String : Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        let photos = picture["photos"] as? [[String: Any]]
        let photo = photos![0]
        let originalSize = photo["original_size"] as! [String: Any]
        let urlString = originalSize["url"] as! String
        let url = URL(string: urlString)
        myImageView.af_setImage(withURL: url!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        
        // add it to the image view;
        myImageView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        myImageView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
  @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            self.performSegue(withIdentifier: "modallySegue", sender: gesture.view)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "modallySegue") {
            let vc = segue.destination as! FullScreenViewController
            
            vc.image = myImageView.image
        }
    }
  
}
