//
//  FullScreenViewController.swift
//  TFeed
//
//  Created by Sanaz Khosravi on 9/9/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController, UIScrollViewDelegate {

   
    @IBOutlet var scrollView: UIScrollView!
    lazy var imageView = UIImageView()
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        let drag = UIPanGestureRecognizer(target: self, action: #selector(imageDragging(_: )))
        self.imageView.addGestureRecognizer(drag)
        self.imageView.isUserInteractionEnabled = true
        
        if let image = image{
            self.imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.imageView.image = image
            self.imageView.contentMode = .scaleAspectFit
            self.scrollView.addSubview(self.imageView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @objc func imageDragging(_ gesture: UIPanGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}



