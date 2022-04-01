//
//  HomeViewModel.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import Foundation
import CoreData

class HomeViewModel {
    private let api = API()
  
    public func getTopBooks(completion: @escaping([DetailBook]) -> ()) {
        api.fetchTop { books in
            completion(books.compactMap({
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
    
    public func getDetailsBook(_ book: DetailBook,
                               context: NSManagedObjectContext) -> DetailBook? {
        guard let user = UserDefaults.standard.object(forKey: "username") as? String else {
            return nil
        }
        return DetailBook(id: book.id,
                          title: book.title,
                          image: book.image,
                          description: book.description,
                          isFavorite: BookFavoriteModel.isBookFav(idBook: book.id,
                                                                  fromUser: user,
                                                                  from: context),
                          author: book.author,
                          rating: book.rating)
    }

    public func isBookFav(_ book: DetailBook,
                          context: NSManagedObjectContext) -> Bool {
        guard let user = UserDefaults.standard.object(forKey: "username") as? String else {
            return false
        }
        if BookFavoriteModel.isBookFav(idBook: book.id,
                                       fromUser: user,
                                       from: context) {
            context.performChanges {
                BookFavoriteModel.removeBook(idBook: book.id,
                                             fromUser: user,
                                             from: context)
            }
            return true
        } else {
            context.performChanges {
                BookFavoriteModel.insert(into: context,
                                         fromUser: user,
                                         book: book)
            }
            return false
        }
    }
}
