//
//  Home.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var todayRecipes: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
	override func viewDidLoad() {
        super.viewDidLoad()
		let defaults = UserDefaults.standard
		if let username = defaults.string(forKey: "username") {
			usernameLabel.text = username
		}
		
		self.todayRecipes.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCell")

		self.todayRecipes.dataSource = self
		self.todayRecipes.delegate = self
    }
    

    @IBAction func logout(_ sender: Any) {
		let defaults = UserDefaults.standard
		defaults.removeObject(forKey: "username")
		defaults.removeObject(forKey: "token")
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

extension Home: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
		cell.image.image = UIImage(named: "olive")
		cell.title.text = "Оливье"
		cell.layer.shadowColor = UIColor.gray.cgColor
		cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
		cell.layer.shadowRadius = 5.0
		cell.layer.shadowOpacity = 1.0
		cell.layer.masksToBounds = false
		cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
		return cell
	}
}

extension Home: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let id = indexPath.item
		print(id)
		
		let storyboard = UIStoryboard(name: "RecipeCard", bundle: nil)
		
		guard let vc = storyboard.instantiateViewController(identifier: "RecipeCard") as? RecipeCard else { return }
//		vc.rec = RecipeModel.getLocationNames()[indexPath.item]
//		vc.itemImage = RecipeModel.getLocationImages()[indexPath.item]

//		let vc = storyboard.instantiateViewController(withIdentifier: "RecipeCard")
		vc.modalPresentationStyle = .fullScreen
		
//		self.navigationController?.pushViewController(vc, animated: true)
		present(vc, animated:true)
		
	}
}
