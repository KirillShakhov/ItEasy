//
//  OverlayView.swift
//  SlideOverTutorial
//
//  Created by Aivars Meijers on 09/09/2020.
//

import UIKit

class LoginViewController: UIViewController {
    
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
