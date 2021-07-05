//
//  GalleryVC.swift
//  UniApp
//
//  Created by Shagirov Maksat on 11.03.2021.
//

import UIKit

class GalleryVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var myScrollView: UIScrollView!
    var images = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageNames = ["1","2","3","4","5","6","7","8","9","10"]
        for name in imageNames {
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            myScrollView.addSubview(imageView)
            images.append(imageView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for(index, imageView) in images.enumerated() {
            imageView.frame.size = myScrollView.frame.size
            imageView.frame.origin.x = myScrollView.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }
        
        let contentWidth = myScrollView.frame.width * CGFloat(images.count)
        myScrollView.contentSize = CGSize(width: contentWidth, height: myScrollView.frame.height)
    }
    
}
