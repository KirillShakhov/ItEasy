//
//  Recipes.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 07.01.2022.
//

import Foundation


class Recipes{
	
	struct Recipe: Codable{
		var id: Int
		var name: String
		var image: String
		var kcal: Double
		var cookingTime: String
		var proteins: Double
		var fats: Double
		var carbohydrates: Double
	}

	static func getRecipes() -> [Recipe]{
		do{
			let res = Sender.querySyncGet(address: "http://127.0.0.1:8090/recipes")
			let json = res.body!.data(using: .utf8)!
			let decoder = JSONDecoder()
			struct Response: Codable {
				var status: String
				var list: [Recipe]
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
}
