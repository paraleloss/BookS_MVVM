//
//  ProfileViewModel.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit
import CoreData

class ProfileViewModel {
    
    public func getInfoUser(fromContext context: NSManagedObjectContext) -> (name: String, image: UIImage)? {
        guard let username = UserDefaults.standard.object(forKey: "username") as? String,
              let password = UserDefaults.standard.object(forKey: "password") as? String else {
            return nil
        }
        guard let userModel = UserModel.fetch(name: username, pwd: password, from: context),
              let imageUser = loadImageFromDiskWith(fileName: userModel.imageURL) else {
                  return nil
              }
        return (userModel.username, imageUser)
    }
    
    public func getFavoritesBooks(fromContext context: NSManagedObjectContext) -> [DetailBook] {
        guard let user = UserDefaults.standard.object(forKey: "username") as? String else {
            return [DetailBook]()
        }
        return BookFavoriteModel.fetch(fromUser: user, from: context).map {
            infoBook($0)
        }
    }
    
    private func infoBook(_ book: BookFavoriteModel) -> DetailBook {
        return DetailBook(id: book.id,
                          title: book.title,
                          image: URL(string: book.image),
                          description: book.descriptionBook,
                          isFavorite: true,
                          author: book.author)
    }
    
    private func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
}

