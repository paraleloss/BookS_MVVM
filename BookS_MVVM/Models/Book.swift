//
//  Book.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import Foundation

struct Book: Codable {
    let id: String
    let volumeInfo: VolumeInfo
    
    struct VolumeInfo: Codable {
        let title: String
        let authors: [String]
        let description: String?
        let imageLinks: Image?
    }
    
    struct Image: Codable {
        let smallThumbnail: URL
        let thumbnail: URL
    }
}

struct Books: Codable {
    let items: [Book]
}
