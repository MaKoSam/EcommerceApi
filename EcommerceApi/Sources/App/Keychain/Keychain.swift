//
//  Keychain.swift
//  App
//
//  Created by Sam Mazniker on 23/04/2020.
//

import Foundation

struct Keychain {
    let password = "..." //Пароль от pgAdmin
    
    let adminPassword = "admin" //Пароль необходимый для добавления новых товаров в бд
}

var keychain = Keychain()
