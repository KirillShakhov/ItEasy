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
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		let defaults = UserDefaults.standard
		if let username = defaults.string(forKey: "username") {
			if let pass = defaults.string(forKey: "pass"){
			let result = Sender.query(address: "http://127.0.0.1:8090/auth?login="+username+"&pass="+pass)
			let json = result.data(using: .utf8)!
			let decoder = JSONDecoder()
			struct Request: Codable {
				var status: String
				var message: String?
			}
			do{
				let product = try decoder.decode(Request.self, from: json)
				if(product.status == "ok") {
					let storyboard = UIStoryboard(name: "Main", bundle: nil)
					let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as UIViewController
					vc.modalPresentationStyle = .fullScreen
					dismiss(animated: false)
					present(vc, animated: false, completion: nil)
				}
				else{
					defaults.removeObject(forKey: "username")
					defaults.removeObject(forKey: "pass")
				}
			}
				catch{
					print("Неожиданная ошибка: \(error).")
					return
				}
			}
		}
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
