//
//  LoadingAuthViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import UIKit

class LoadingAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	override func viewDidAppear(_ animated: Bool) {
		let defaults = UserDefaults.standard
		if defaults.string(forKey: "token") != nil {
			let result = Sender.querySyncGetJSON(path: "/users")
			print(result)
			if(result.code == 200) {
				goToView(name: "Main", withIdentifier: "MainViewController")
			}
			else{
				print("Не достоин")
				defaults.removeObject(forKey: "token")
				goToView(name: "Auth", withIdentifier: "Auth")
			}
		}
		else{
			goToView(name: "Auth", withIdentifier: "Auth")
		}
	}
	
	func goToView(name: String, withIdentifier: String){
		let storyboard = UIStoryboard(name: name, bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: withIdentifier) as UIViewController
		vc.modalPresentationStyle = .fullScreen
		dismiss(animated: false)
		present(vc, animated: true, completion: nil)
	}
	
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
