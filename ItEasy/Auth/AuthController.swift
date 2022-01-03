//
//  ViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 03.01.2022.
//

import UIKit
import CardSlider




class AuthController: UIViewController {
    
    @IBOutlet weak var logoBlur: UIVisualEffectView!
    
    @IBAction func login(_ sender: UIButton) {
		let slideVC = LoginViewController()
		slideVC.modalPresentationStyle = .custom
		slideVC.transitioningDelegate = self
		self.present(slideVC, animated: true, completion: nil)
    }

    
    
    @IBAction func register(_ sender: UIButton) {
		let slideVC = RegisterViewController()
		slideVC.modalPresentationStyle = .custom
		slideVC.transitioningDelegate = self
		self.present(slideVC, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//	func goToNextPage(){
//		let storyboard = UIStoryboard(name: "StoryboardName", bundle: nil)
//		let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerID") as UIViewController
//		present(vc, animated: true, completion: nil)
//	}
}

extension AuthController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
