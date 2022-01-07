//
//  GroceryList.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import UIKit

class GroceryList: UIViewController {
	
    @IBOutlet weak var groceryListTable: UITableView!
	
	var menu: MenuModel.Menu?
	var recipes: [RecipeModel.Recipe] = []
	var ingridients: [RecipeModel.Ingredients] = []
    override func viewDidLoad() {
        super.viewDidLoad()
		
        groceryListTable.dataSource = self
        groceryListTable.delegate = self
		
        groceryListTable.register(UINib(nibName: "GroceryListCell", bundle: nil), forCellReuseIdentifier: "GroceryListCell")
		updateGroceryList()
    }
	
	func updateGroceryList(){
		let id = MenuModel.getSelectedMenu()
			if(id != nil){
				menu = MenuModel.getMenuInfo(id: id!)
				switch Date().dayNumberOfWeek()!{
					case 1:
					recipes = (menu?.sunday)!
						print("1")
						break
					case 2:
					recipes = (menu?.monday)!
						break
					case 3:
					recipes = (menu?.tuesday)!
						break
					case 4:
					recipes = (menu?.wednesday)!
						break
					case 5:
					recipes = (menu?.thursday)!
						break
					case 6:
					recipes = (menu?.friday)!
						break
					case 7:
					recipes = (menu?.saturday)!
						break
					default:
						return
				}
				print(recipes)
				for i in recipes{
					ingridients.append(contentsOf: RecipeModel.getRecipeInfo(id: i.id)?.ingredients ?? [])
				}
				print(ingridients)
				groceryListTable.reloadData()
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		updateGroceryList()
	}
    
}

extension GroceryList: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
}

extension GroceryList: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ingridients.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = groceryListTable.dequeueReusableCell(withIdentifier: "GroceryListCell", for: indexPath) as! GroceryListCell
		let ingridient = ingridients[indexPath.item]
		cell.name.text = ingridient.product.name
		cell.count.text = ingridient.count
		cell.ingridient = ingridient
		return cell
	}
}
