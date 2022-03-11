//
//  ProfileView.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import Foundation
import UIKit

protocol ProfileViewDelegate: AnyObject {
    func tapFavBook(_ book: DetailBook)
}

class ProfileView: UIView {
    weak var delegate: ProfileViewDelegate?
    let imageUserView = UIImageView()
    let nameLabel = UILabel()
    let favLabel = UILabel()
    let listBooksView = ListBooksView()
    
    init(){
        super.init(frame: .zero)
        setupView()
    }
    
    public func setInfo(name: String, image: UIImage) {
        nameLabel.text = name
        imageUserView.image = image
    }
    
    private func setupView() {
        addSubview(imageUserView)
        imageUserView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageUserView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageUserView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            imageUserView.heightAnchor.constraint(equalToConstant: 120),
            imageUserView.widthAnchor.constraint(equalToConstant: 120),
        ])
        imageUserView.clipsToBounds = true
        imageUserView.layer.masksToBounds = true
        imageUserView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        imageUserView.layer.borderWidth = 4
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: imageUserView.bottomAnchor, constant: 10)
        ])
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        addSubview(favLabel)
        favLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: 20),
            favLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                          constant: 20),
        ])
        favLabel.text = "Tus libros"
        favLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        addSubview(listBooksView)
        listBooksView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listBooksView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listBooksView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listBooksView.topAnchor.constraint(equalTo: favLabel.bottomAnchor,
                                               constant: 20),
            listBooksView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        listBooksView.delegate = self
    }

    public func fillFavoritesBooks(_ books: [DetailBook]) {
        listBooksView.fill(books)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageUserView.layer.cornerRadius = imageUserView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView: ListBooksViewDelegate {
    func didSelectBook(_ book: DetailBook) {
        delegate?.tapFavBook(book)
    }
}
