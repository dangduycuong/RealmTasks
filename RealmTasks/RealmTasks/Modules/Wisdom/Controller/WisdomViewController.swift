//
//  WisdomViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomViewController: BaseViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        let jeremyGif = UIImage.gifImageWithName("galaxy")
        
        let imageView = UIImageView(image: jeremyGif)
        imageView.layer.cornerRadius = 25
        backgroundImageView.layout(imageView)
            .top().left().bottom().right()
    }
    
    @IBAction func nextDetail(_ sender: UIButton) {
        if let vc = R.storyboard.wisdom.wisdomDetailViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
