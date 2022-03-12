//
//  ListBooksView.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit

protocol ListBooksViewDelegate: AnyObject {
    func didSelectBook(_ book: DetailBook)
}

class ListBooksView: UIView {
    weak var delegate: ListBooksViewDelegate?
    let tableView = UITableView()
    var books = [DetailBook]()
    let colorAlternativo = UIColor(red: 172/255, green: 158/255, blue: 131/255, alpha: 1.00)
    
    init() {
        super.init(frame: .zero)
        setupView()
       // self.backgroundColor = .clear
    }

    public func fill(_ books: [DetailBook]) {
        self.books = books
        tableView.reloadData()
       // self.setBackgroundImage("a", contentMode: .scaleAspectFill)
    }
    
    private func setupView() {
       //tableView.backgroundColor = colorAlternativo
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListBooksView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        cell.book = books[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectBook(books[indexPath.item])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
