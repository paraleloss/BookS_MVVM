//
//  DetailBookViewController.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit
import CoreData

class DetailBookViewController: UIViewController {
    private(set) var managedObjectContext: NSManagedObjectContext
    let book: DetailBook
    let viewModel = HomeViewModel()
    let detailView: DetailBookView
    
    init(book: DetailBook, context: NSManagedObjectContext) {
        self.book = book
        managedObjectContext = context
        detailView = DetailBookView(book: viewModel.getDetailsBook(book, context: managedObjectContext))
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   view.backgroundColor = UIColor.systemBackground
     //   self.setBackgroundImage("a", contentMode: .scaleAspectFill)
        setupView()
    }
    
    private func showAlertFavorite(isFavorite: Bool) {
        let alertController = UIAlertController(title: nil,
                                                message: isFavorite ? "Se quitó de favoritos" : "Agregado a favoritos",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
        present(alertController, animated: true)
    }
    
    private func setupView() {
        title = "Acerca de este libro"
        hidesBottomBarWhenPushed = false
        detailView.delegate = self
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailBookViewController: DetailBookViewDelegate {
    func favBook() {
        guard var detailBook = viewModel.getDetailsBook(book, context: managedObjectContext) else {
            return
        }
        detailBook.isFavorite(!detailBook.isFavorite)
        detailView.updateBook(detailBook)
        showAlertFavorite(isFavorite: viewModel.isBookFav(book, context: managedObjectContext))

    }
}

