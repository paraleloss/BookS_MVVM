//
//  NSManagedObjectContext+Extensions.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//


import CoreData

final class BookFavoriteModel: NSManagedObject, Managed {
    @NSManaged fileprivate(set) var id: String
    @NSManaged var user: String
    @NSManaged var image: String
    @NSManaged var title: String
    @NSManaged var author: String
    @NSManaged var descriptionBook: String
    
    static func insert(into context: NSManagedObjectContext,
                       fromUser: String,
                       book: DetailBook)  {
        let bookModel: BookFavoriteModel = context.insertObject()
        bookModel.id = book.id
        bookModel.title = book.title
        bookModel.descriptionBook = book.description ?? ""
        bookModel.author = book.author
        bookModel.image = book.image?.absoluteString ?? ""
        bookModel.user = fromUser
    }
    
    static func fetch(fromUser: String, from context: NSManagedObjectContext ) -> [BookFavoriteModel] {
        let predicate = NSPredicate(format: "%K == %@",
                                    #keyPath(user),
                                    fromUser)
        let request = BookFavoriteModel.sortedFetchRequest
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            return [BookFavoriteModel]()
        }
    }
    
    
    static func isBookFav(idBook: String,
                          fromUser: String,
                          from context: NSManagedObjectContext) -> Bool {
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@",
                                    #keyPath(id),
                                    idBook,
                                    #keyPath(user),
                                    fromUser)
        let request = BookFavoriteModel.sortedFetchRequest
        request.predicate = predicate
        do {
            if let _ =  try context.fetch(request).first {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
  
    static func removeBook(idBook: String,
                           fromUser: String,
                           from context: NSManagedObjectContext) {
        let predicate = NSPredicate(format: "%K == %@",
                                    #keyPath(id),
                                    idBook,
                                    #keyPath(user),
                                    fromUser)
        let request = BookFavoriteModel.sortedFetchRequest
        request.predicate = predicate
        do {
            if let book = try context.fetch(request).first {
                context.delete(book)
            }
        } catch {
            return
        }
    }

}

