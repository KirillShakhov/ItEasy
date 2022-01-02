//
//  ViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 03.01.2022.
//

import UIKit
import CardSlider




class ViewController: UIViewController {
    
    @IBOutlet weak var logoBlur: UIVisualEffectView!
    
    @IBAction func login(_ sender: UIButton) {
        
    }
    
    @objc func showMiracle() {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        showMiracle()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
