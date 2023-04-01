//
//  RollsViewController.swift
//  pizza2
//
//  Created by Alexey Ivanov on 1/4/23.
//

import UIKit


class RollsViewController: UIViewController, ViewControllerContainable {
    var containerView: UIView {
        collectionViewContainer
    }
    
    @IBOutlet weak var collectionViewContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = appDelegate.promotionViewController
        present(viewController: vc, animated: true, duration: 1, delay: 0.2)
    }
}
