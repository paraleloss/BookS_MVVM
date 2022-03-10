//
//  File.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 09/03/22.
//

import Foundation

class API {

    func fetchTop(completion: @escaping([Book]) -> Void) {
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=top")!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return completion([Book]())
            }
            do {
                let books = try JSONDecoder().decode(Books.self, from: data)
                return completion(books.items)
            } catch let error{
                print(error)
                completion([Book]())
            }
        }
        task.resume()
    }
    
    func fetchWithSearch(_ search: String, completion: @escaping([Book]) -> Void) {
        let search = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(search)")!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return completion([Book]())
            }
            do {
                let books = try JSONDecoder().decode(Books.self, from: data)
                return completion(books.items)
            } catch {
                completion([Book]())
            }
        }
        task.resume()
    }
}

