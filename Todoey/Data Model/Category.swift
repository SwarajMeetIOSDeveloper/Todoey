//
//  Category.swift
//  Todoey
//
//  Created by Appolar on 05/12/18.
//  Copyright © 2018 Appolar. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()

}
