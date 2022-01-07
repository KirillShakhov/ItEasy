//
//  OverlayView.swift
//  SlideOverTutorial
//
//  Created by Aivars Meijers on 09/09/2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBAction func login(_ sender: Any) {
		do{
			let json_req: [String: Any] = ["username": loginField.text!,
									   "password": passField.text!]

			let result = Sender.querySyncPostJSON(path: "/signin", json: json_req);
			print(result)
			
			let json = result.body!.data(using: .utf8)!
			let decoder = JSONDecoder()
			struct Request: Codable {
				var accessToken: String?
			}
		
			let req = try decoder.decode(Request.self, from: json)
			if req.accessToken != nil {
				let defaults = UserDefaults.standard
				defaults.set("Bearer "+req.accessToken!, forKey: "token")
				print("Bearer "+req.accessToken!)
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as UIViewController
				vc.modalPresentationStyle = .fullScreen
				present(vc, animated: true, completion: nil)
				
//				else{
//					let alert = UIAlertController(title: "Авторизация", message: product.message, preferredStyle: .alert)
//					alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
//					self.present(alert, animated: true)
//				}
			}
		}
		catch{
			return
		}
    }
    
    var hasSetPointOrigin = false
    @IBOutlet weak var loginButton: UIButton!
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
       didSet {
           updateView()
        }
     }
    
     @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
     }
         
     
         
    var pointOrigin: CGPoint?
    
    @IBOutlet weak var slideIdicator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        slideIdicator.roundCorners(.allCorners, radius: 10)
		
		
	
		 let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
		view.addGestureRecognizer(tap)

		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
	
	//Calls this function when the tap is recognized.
	@objc func dismissKeyboard() {
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
	}
    
    func updateView() {
        let layer = loginButton.layer as! CAGradientLayer

        layer.colors = [firstColor, secondColor].map{$0.cgColor}
     }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 700)
                }
            }
        }
		dismissKeyboard()
    }
	
	@objc func keyboardWillShow(notification: NSNotification) {
		self.view.frame.origin.y = 100
	}

	@objc func keyboardWillHide(notification: NSNotification) {
		self.view.frame.origin.y = (self.pointOrigin ?? CGPoint(x: 0, y: 700)).y
	}
}
