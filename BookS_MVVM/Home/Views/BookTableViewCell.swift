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
    let backgroundCoverImageView = UIView()
    let startsView = StartsView()

    var book: DetailBook? {didSet{
        guard let book = book else {
            return
        }
        titleLabel.text = book.title
        authorLabel.text = book.author
        coverImageView.downloaded(from: book.image)
        startsView.rating = book.rating
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.systemBackground
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(backgroundCoverImageView)
        backgroundCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: 10),
            backgroundCoverImageView.heightAnchor.constraint(equalToConstant: 120),
            backgroundCoverImageView.widthAnchor.constraint(equalToConstant: 150),
            backgroundCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        backgroundCoverImageView.backgroundColor = UIColor.random()
        backgroundCoverImageView.clipsToBounds = true
        backgroundCoverImageView.layer.masksToBounds = true
        backgroundCoverImageView.layer.cornerRadius = 4
        backgroundCoverImageView.dropShadow()
        
        contentView.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.centerXAnchor.constraint(equalTo: backgroundCoverImageView.centerXAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 180),
            coverImageView.widthAnchor.constraint(equalToConstant: 100),
            coverImageView.bottomAnchor.constraint(equalTo: backgroundCoverImageView.bottomAnchor)
        ])
        coverImageView.dropShadow()
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundCoverImageView.trailingAnchor,
                                                constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -20)
        ])
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        contentView.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: backgroundCoverImageView.trailingAnchor,
                                                constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -20)
        ])
        authorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        
        contentView.addSubview(startsView)
        startsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startsView.leadingAnchor.constraint(equalTo: backgroundCoverImageView.trailingAnchor,
                                                constant: 20),
            startsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            startsView.heightAnchor.constraint(equalToConstant: 55),
            startsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

