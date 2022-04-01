//
//  SearchViewModel.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import Foundation

class SeachViewModel {
    private let api = API()
  
    public func searchBooks(_ search: String, completion: @escaping([DetailBook]) -> ()) {
        api.fetchWithSearch(search) { books in
            completion(books.map({
                self.getDetailBook($0)
            }))
        }
    }
    
    private func getDetailBook(_ book: Book) -> DetailBook {
        return DetailBook(id: book.id,
                          title: book.volumeInfo.title,
                          image: book.volumeInfo.imageLinks?.thumbnail,
                          description: book.volumeInfo.description,
                          isFavorite: false,
                          author: book.volumeInfo.authors.first ?? "",
                          rating: book.volumeInfo.averageRating ?? 0)
    }
}
