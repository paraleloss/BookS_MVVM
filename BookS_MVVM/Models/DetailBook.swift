//
//  DetailBook.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 09/03/22.
//

import UIKit

struct DetailBook {
    let id: String
    let title: String
    let image: URL?
    let description: String?
    var isFavorite: Bool
    var author: String
    
    mutating func isFavorite(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}
