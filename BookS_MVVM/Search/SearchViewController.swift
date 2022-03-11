//
//  SearchViewController.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    private(set) var managedObjectContext: NSManagedObjectContext
    let activityIndicator = UIActivityIndicatorView()
    let searchController = UISearchController(searchResultsController: nil)
    let listBooksView = ListBooksView()
    let emptySearchView = EmptySearchView()
    let viewModel = SeachViewModel()
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var filteredBooks = [Book]()
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setBackgroundImage("asd", contentMode: .scaleAspectFill)
        setup()
        setupSearchController()
    }
    
    private func setup() {
        title = "Search"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.systemBackground
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
        view.addSubview(emptySearchView)
        emptySearchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptySearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptySearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptySearchView.topAnchor.constraint(equalTo: view.topAnchor),
            emptySearchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func showEmptyView(withSearch search: String) {
        emptySearchView.updateTitle(withSearch: search)
        emptySearchView.isHidden = false
    }
    
    func hideEmptyView() {
        emptySearchView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let search = searchBar.text else {
            return
        }
        activityIndicator.startAnimating()
        viewModel.searchBooks(search) { books in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if books.isEmpty && !search.isEmpty {
                    self.showEmptyView(withSearch: search)
                } else {
                    self.hideEmptyView()
                }
                self.listBooksView.fill(books)
            }
        }
    }
}


extension SearchViewController: ListBooksViewDelegate {
    func didSelectBook(_ book: DetailBook) {
        listBooksView.endEditing(true)
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(DetailBookViewController(book: book,
                                                                          context: managedObjectContext),
                                                 animated: true)
        hidesBottomBarWhenPushed = false
    }
}
