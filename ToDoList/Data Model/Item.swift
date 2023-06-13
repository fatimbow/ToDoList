//
//  Item.swift
//  ToDoList
//
//  Created by fatma y on 13.06.2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
}
