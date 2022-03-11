//
//  DetailBookView.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import Foundation
import UIKit

protocol DetailBookViewDelegate: AnyObject {
    func favBook()
}

class DetailBookView: UIView {
    weak var delegate: DetailBookViewDelegate?
    let tableView = UITableView()
    var book: DetailBook?
    
    init(book: DetailBook?) {
        self.book = book
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.systemBackground
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
        tableView.register(HeaderDetailBookTableViewCell.self, forCellReuseIdentifier: "cellHeader")
        tableView.register(InfoDetailBookTableViewCell.self, forCellReuseIdentifier: "cellInfo")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    public func updateBook(_ book: DetailBook) {
        self.book = book
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DetailBookView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath) as? HeaderDetailBookTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.book = book
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfo", for: indexPath) as? InfoDetailBookTableViewCell else {
                return UITableViewCell()
            }
            cell.book = book
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 200
        default: return UITableView.automaticDimension
        }
    }
}


extension DetailBookView: HeaderDetailBookCellDelegate {
    func tapFavorite() {
        delegate?.favBook()
    }
}
