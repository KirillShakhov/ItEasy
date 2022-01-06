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
//		let defaults = UserDefaults.standard
//		if let username = defaults.string(forKey: "username") {
//			if let pass = defaults.string(forKey: "pass"){
//				do{
//					let result = Sender.query(address: "http://127.0.0.1:8090/auth?login="+username+"&pass="+pass)
//					let json = result.data(using: .utf8)!
//					let decoder = JSONDecoder()
//					struct Request: Codable {
//						var status: String
//						var message: String?
//					}
//					do{
//						let product = try decoder.decode(Request.self, from: json)
//						if(product.status == "ok") {
//							goToView(name: "Main", withIdentifier: "MainViewController")
//						}
//						else{
//							defaults.removeObject(forKey: "username")
//							defaults.removeObject(forKey: "pass")
//							goToView(name: "Auth", withIdentifier: "Auth")
//						}
//					}
//						catch{
//							print("Неожиданная ошибка: \(error).")
//							return
//						}
//					}
//				catch{
//					exit(0)
//				}
//			}
//		}
//		else{
//			goToView(name: "Auth", withIdentifier: "Auth")
//		}
		
		goToView(name: "Main", withIdentifier: "MainViewController")

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
