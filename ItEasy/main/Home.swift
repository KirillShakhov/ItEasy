//
//  Home.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import UIKit

class Home: UIViewController {

	@IBOutlet weak var usernameLabel: UILabel!
	override func viewDidLoad() {
        super.viewDidLoad()
		let defaults = UserDefaults.standard
		if let username = defaults.string(forKey: "username") {
			usernameLabel.text = username
		}
    }
    

    @IBAction func logout(_ sender: Any) {
		let defaults = UserDefaults.standard
		defaults.removeObject(forKey: "username")
		defaults.removeObject(forKey: "pass")
		dismiss(animated: true)
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
