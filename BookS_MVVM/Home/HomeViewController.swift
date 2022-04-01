//
//  HomeViewController.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    private(set) var managedObjectContext: NSManagedObjectContext
    let activityIndicator = UIActivityIndicatorView()
    let viewModel = HomeViewModel()
    let listBooksView = ListBooksView()
    let colorAlternativo = UIColor(red: 172/255, green: 158/255, blue: 131/255, alpha: 1.00)

    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
        getTopBooks()
        //self.setBackgroundImage2("a", contentMode: .scaleAspectFill)
    }
    
    private func setup() {
        view.backgroundColor = UIColor.systemBackground
        //view.backgroundColor = colorAlternativo
        title = "Inicio"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(listBooksView)
        listBooksView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listBooksView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listBooksView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listBooksView.topAnchor.constraint(equalTo: view.topAnchor),
            listBooksView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        listBooksView.delegate = self
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        activityIndicator.hidesWhenStopped = true
    }
 
    private func getTopBooks() {
        activityIndicator.startAnimating()
        viewModel.getTopBooks { books in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.listBooksView.fill(books)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewController: ListBooksViewDelegate {
    func didSelectBook(_ book: DetailBook) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(DetailBookViewController(book: book,
                                                                          context: managedObjectContext),
                                                 animated: true)
        hidesBottomBarWhenPushed = false
    }
}

