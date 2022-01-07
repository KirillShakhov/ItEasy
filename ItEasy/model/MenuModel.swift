//
//  MenuModel.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 07.01.2022.
//
import Foundation
import UIKit

class MenuModel{
	
	struct Menu: Codable{
		var id: Int
		var name: String
		var image: String
		var description: String

		var monday: [RecipeModel.Recipe]?
		var tuesday: [RecipeModel.Recipe]?
		var wednesday: [RecipeModel.Recipe]?
		var thursday: [RecipeModel.Recipe]?
		var friday: [RecipeModel.Recipe]?
		var saturday: [RecipeModel.Recipe]?
		var sunday: [RecipeModel.Recipe]?
	}

	static func getMenu() -> [Menu]{
		do{
			let res = Sender.querySyncGet(path: "/menu")
			let json = res.body!.data(using: .utf8)!
			let decoder = JSONDecoder()
			struct Response: Codable {
				var status: String
				var list: [Menu]
			}
			let result = try decoder.decode(Response.self, from: json)
			
			if(result.status == "ok"){
				return result.list
			}
			else{
				print(result.status)
			}
		}catch{
			print(error)
		}
		return []
	}
	
	static func getMenuInfo(id: Int) -> Menu?{
		do{
			let res = Sender.querySyncGet(path: "/menu/info?id="+String(id))
			let json = res.body!.data(using: .utf8)!
			let decoder = JSONDecoder()
			struct Response: Codable {
				var status: String
				var item: Menu
			}
			let result = try decoder.decode(Response.self, from: json)
			
			if(result.status == "ok"){
				return result.item
			}
			else{
				print(result.status)
			}
		}catch{
			print(error)
		}
		return nil
	}
}
