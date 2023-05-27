//
//  Item.swift
//  ToDoList
//
//  Created by fatma y on 24.05.2023.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
