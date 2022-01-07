//
//  OverlayView.swift
//  SlideOverTutorial
//
//  Created by Aivars Meijers on 09/09/2020.
//

import UIKit

class RegisterViewController: UIViewController {
    
	@IBOutlet weak var slideIdicator: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
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
	
    
    @IBAction func register(_ sender: UIButton) {
		do{
			let json_req: [String: Any] = [
				"name": loginField.text!,
				"username": loginField.text!,
				"email": emailField.text!,
				"password": passField.text!,
				"profilePicUrl": ""
			]
			let username = loginField.text!
			let password = passField.text!

			var result = Sender.querySyncPostJSON(path: "/users", json: json_req)
			var json = result.body!.data(using: .utf8)!
			let decoder = JSONDecoder()
			struct Request: Codable {
				var success: Bool?
				var error: String?
			}
			let req = try decoder.decode(Request.self, from: json)
			if req.success == true {
				let json_req: [String: Any] = ["username": username,
											   "password": password]
				print(username)
				print(password)
				result = Sender.querySyncPostJSON(path: "/signin", json: json_req);
				struct Request: Codable {
					var accessToken: String?
				}
				json = result.body!.data(using: .utf8)!
				let req = try decoder.decode(Request.self, from: json)
				if req.accessToken != nil {
					let defaults = UserDefaults.standard
					defaults.set("Bearer "+req.accessToken!, forKey: "token")
					defaults.set(loginField.text, forKey: "username")
					let storyboard = UIStoryboard(name: "Main", bundle: nil)
					let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as UIViewController
					vc.modalPresentationStyle = .fullScreen
					present(vc, animated: true, completion: nil)
				}
				else{
					let alert = UIAlertController(title: "Регистрация", message: "Неправильные данные", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
					self.present(alert, animated: true)
				}
			}
			else{
				let alert = UIAlertController(title: "Регистрация", message: req.error, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
				self.present(alert, animated: true)
			}
		}
		catch{
			return
		}
	}
	
	func goToMain(){
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as UIViewController
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true, completion: nil)
	}

	
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
	//Calls this function when the tap is recognized.
	@objc func dismissKeyboard() {
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
	}
	
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
		let windowTranslation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard windowTranslation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + windowTranslation.y)
        
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
		  // move the root view up by the distance of keyboard height
		  self.view.frame.origin.y = 100
	  }

	@objc func keyboardWillHide(notification: NSNotification) {

	  // move back the root view origin to zero
		self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 700)
	}
}
