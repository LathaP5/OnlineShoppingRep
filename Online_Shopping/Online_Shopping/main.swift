//
//  main.swift
//  Online_Shopping_Application
//
//  Created by latha-16226 on 14/02/23.
//

import Foundation


SqliteDatabase.getObject().createDatabase()
var onlineShopping = OnlineShopping()
try onlineShopping.menus()
