//
//  User.swift
//  mvvm_combine
//
//  Created by Tommy den Reijer on 05/05/2021.
//

import Foundation


struct User: Decodable, Identifiable{
	let id: Int
	let name: String
}
