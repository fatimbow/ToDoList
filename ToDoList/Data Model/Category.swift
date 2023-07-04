//
//  Category.swift
//  ToDoList
//
//  Created by fatma y on 13.06.2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var categoryColor: String = ""
    let items = List<Item>()
}
