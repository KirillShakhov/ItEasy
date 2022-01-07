//
//  Sender.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import Foundation

class Sender{
//	static func querySync(address: String) -> String {
//		let url = URL(string: address)
//		let semaphore = DispatchSemaphore(value: 0)
//
//		var result: String = ""
//
//		let defaults = UserDefaults.standard
//		if let token = defaults.string(forKey: "token") {
//			request.addValue(token, forHTTPHeaderField: "Authorization")
//		}
//
//		let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//			result = String(data: (data ?? "".data(using: String.Encoding.utf8))!, encoding: String.Encoding.utf8)!
//			semaphore.signal()
//		}
//
//		task.resume()
//		semaphore.wait()
//		return result
//	}
	
	struct Response{
		var body: String?
		var code: Int?
	}
	
	//http://109.107.181.107:8090
	static func querySyncJSON(address: String = "http://127.0.0.1:8090", path: String, json: [String: Any]?, method: String) -> Response {
		let semaphore = DispatchSemaphore(value: 0)
		// prepare json data

//		let json: [String: Any] = ["title": "ABC",
//								   "dict": ["1":"First", "2":"Second"]]

		

		// create post request
		let url = URL(string: (address+path).encodeUrl)!
		var request = URLRequest(url: url)
		request.httpMethod = method
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		
		
		let defaults = UserDefaults.standard
		if let token = defaults.string(forKey: "token") {
			request.addValue(token, forHTTPHeaderField: "Authorization")
		}
		
		if json != nil{
			request.httpBody =  try? JSONSerialization.data(withJSONObject: json ?? "")
		}
		
		var res = Response()

		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			
//			let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//			if let responseJSON = responseJSON as? [String: Any] {
//				print(responseJSON)
//			}
			guard let httpResponse = response as? HTTPURLResponse, error == nil else {
					print("No valid response")
					return
			}
			guard 200 ..< 600 ~= httpResponse.statusCode else {
				   print("Status code was \(httpResponse.statusCode), but expected 2xx")
				return
			}
			res.code = httpResponse.statusCode
			
//			guard let data = data, error == nil else {
//				return res
//			}
			if(data != nil){
				res.body = String(data: (data!), encoding: String.Encoding.utf8)!
			}
			semaphore.signal()
		}

		task.resume()
		semaphore.wait()
		return res
	}
	static func querySyncPostJSON(path: String, json: [String: Any]) -> Response {
		return querySyncJSON(path: path, json: json, method: "POST")
	}
	static func querySyncGetJSON(path: String, json: [String: Any]) -> Response {
		return querySyncJSON(path: path, json: json, method: "GET")
	}
	static func querySyncPostJSON(path: String) -> Response {
		return querySyncJSON(path: path, json: nil, method: "POST")
	}
	static func querySyncGetJSON(path: String) -> Response {
		return querySyncJSON(path: path, json: nil, method: "GET")
	}
	static func querySyncPost(path: String) -> Response {
		return querySyncJSON(path: path, json: nil, method: "POST")
	}
	static func querySyncGet(path: String) -> Response {
		return querySyncJSON(path: path, json: nil, method: "GET")
	}
//	static func query(address: String) -> String {
//		return querySync(address: address)
//	}
}
extension String{
	var encodeUrl : String
	{
		return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
	}
	var decodeUrl : String
	{
		return self.removingPercentEncoding!
	}
}
