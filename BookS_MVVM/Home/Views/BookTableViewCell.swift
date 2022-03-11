//
//  BookTableViewCell.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let coverImageView = UIImageView()
    
    var book: DetailBook? {didSet{
        guard let book = book else {
            return
        }
        titleLabel.text = book.title
        authorLabel.text = book.author
        coverImageView.downloaded(from: book.image)
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.backgroundColor = .clear
    }
    
    private func setupView() {
        contentView.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: 10),
            coverImageView.heightAnchor.constraint(equalToConstant: 180),
            coverImageView.widthAnchor.constraint(equalToConstant: 100),
            coverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor,
                                                constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -20)
        ])
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        contentView.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                constant: -40),
            authorLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor,
                                                constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -20)
        ])
        authorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

