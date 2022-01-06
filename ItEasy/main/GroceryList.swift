//
//  GroceryList.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import UIKit

class GroceryList: UIViewController {
	
    @IBOutlet weak var groceryListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        groceryListTable.dataSource = self
        groceryListTable.delegate = self
		
        groceryListTable.register(UINib(nibName: "GroceryListCell", bundle: nil), forCellReuseIdentifier: "GroceryListCell")

    }
    
}

extension GroceryList: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
}

extension GroceryList: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = groceryListTable.dequeueReusableCell(withIdentifier: "GroceryListCell", for: indexPath)
		return cell
	}
}
