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
	
    @IBOutlet weak var todayLabel: UILabel!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var selectedMenuImage: RecipeCardImage!
    @IBOutlet weak var selectedMenuLabel: UILabel!
    
	var menuImageURL: String?
    var menu: MenuModel.Menu?
	var recipes: [RecipeModel.Recipe] = []
	override func viewDidLoad() {
        super.viewDidLoad()
		let defaults = UserDefaults.standard
		if let username = defaults.string(forKey: "username") {
			usernameLabel.text = username
		}
		
		self.todayRecipes.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCell")

		self.todayRecipes.dataSource = self
		self.todayRecipes.delegate = self
		
		updateMenu()
		
    }
	
	func updateMenu(){
        let id = MenuModel.getSelectedMenu()
		if(id != nil && id != -1){
			menu = MenuModel.getMenuInfo(id: id!)
			switch Date().dayNumberOfWeek()!{
				case 1:
				recipes = (menu?.sunday)!
				todayLabel.text = "Sunday"
					print("1")
					break
				case 2:
				recipes = (menu?.monday)!
				todayLabel.text = "Monday"
					print("2")
					break
				case 3:
				recipes = (menu?.tuesday)!
				todayLabel.text = "Tuesday"
					print("3")
					break
				case 4:
				recipes = (menu?.wednesday)!
				todayLabel.text = "Wednesday"
					print("4")
					break
				case 5:
				recipes = (menu?.thursday)!
				todayLabel.text = "Thursday"
					print("5")
					break
				case 6:
				recipes = (menu?.friday)!
				todayLabel.text = "Friday"
					print("6")
					break
				case 7:
				recipes = (menu?.saturday)!
				todayLabel.text = "Saturday"
					print("7")
					break
				default:
					return
			}
			todayRecipes.reloadData()
			selectedMenuLabel.text = menu?.name
			if(menuImageURL != menu?.image){
					selectedMenuImage.image = nil
					activityIndicator.isHidden = false
					menuImageURL = menu?.image
					DispatchQueue.global().async {
						if let data = try? Data(contentsOf: URL(string: self.menu!.image)!) {
							if let image = UIImage(data: data) {
								DispatchQueue.main.async {
									self.selectedMenuImage.image = image
									self.activityIndicator.isHidden = true
							}
						}
					}
				}
			}
		}
		else{
			self.selectedMenuLabel.text = "Меню не выбрано"
			self.activityIndicator.isHidden = true
			switch Date().dayNumberOfWeek()!{
				case 1:
					todayLabel.text = "Sunday"
					break
				case 2:
					todayLabel.text = "Monday"
					break
				case 3:
					todayLabel.text = "Tuesday"
					break
				case 4:
					todayLabel.text = "Wednesday"
					break
				case 5:
					todayLabel.text = "Thursday"
					break
				case 6:
					todayLabel.text = "Friday"
					break
				case 7:
					todayLabel.text = "Saturday"
					break
				default:
					return
			}
		}
	}
    
    override func viewDidAppear(_ animated: Bool) {
        updateMenu()
    }
	
    @IBAction func logout(_ sender: Any) {
		let defaults = UserDefaults.standard
		defaults.removeObject(forKey: "username")
		defaults.removeObject(forKey: "token")
		dismiss(animated: true)
    }
}

extension Home: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
		let recipe = recipes[indexPath.item]
		cell.title.text = recipe.name
		cell.kcal.text = String(format: "%.1f", recipe.kcal)
		if(cell.imageURL != recipe.image){
			cell.image.image = nil
			cell.imageURL = recipe.image
			cell.activityIndicator.isHidden = false
			DispatchQueue.global().async {
				if let data = try? Data(contentsOf: URL(string: recipe.image)!) {
					if let image = UIImage(data: data) {
						DispatchQueue.main.async {
							cell.image.image = image
							cell.activityIndicator.isHidden = true
						}
					}
				}
			}
		}
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
		return recipes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "RecipeCard", bundle: nil)
		guard let vc = storyboard.instantiateViewController(identifier: "RecipeCard") as? RecipeCard else { return }
		vc.recipe = recipes[indexPath.item]
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated:true)
		
	}
}
extension Date {
	func dayNumberOfWeek() -> Int? {
		return Calendar.current.dateComponents([.weekday], from: self).weekday
	}
}
