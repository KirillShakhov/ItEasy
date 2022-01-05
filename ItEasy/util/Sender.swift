//
//  Sender.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import Foundation

class Sender{
	static func querySync(address: String) -> String {
		let url = URL(string: address)
		let semaphore = DispatchSemaphore(value: 0)
		
		var result: String = ""
			
		let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
			result = String(data: (data ?? "".data(using: String.Encoding.utf8))!, encoding: String.Encoding.utf8)!
			semaphore.signal()
		}
		
		task.resume()
		semaphore.wait()
		return result
	}
	
	static func query(address: String) -> String {
		return querySync(address: address)
	}
}
