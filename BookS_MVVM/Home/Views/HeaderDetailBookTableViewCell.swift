//
//  HeaderDetailBookTableViewCell.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit

protocol HeaderDetailBookCellDelegate: AnyObject {
    func tapFavorite()
}

class HeaderDetailBookTableViewCell: UITableViewCell {
    weak var delegate: HeaderDetailBookCellDelegate?
    let coverImageView = UIImageView()
    let nameLabel = UILabel()
    let favButton = UIButton()
    
    var book: DetailBook? {didSet{
        guard let book = book else {
            return
        }
        coverImageView.downloaded(from: book.image)
        nameLabel.text = book.title
        if book.isFavorite {
            favButton.setTitle("Quitar de Favoritos ➖", for: .normal)
        } else {
            favButton.setTitle("Agregar a favoritos ⭐️", for: .normal)
        }
    }}
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: 20),
            coverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 250),
            coverImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor,
                                               constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: 20)
        ])
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        contentView.addSubview(favButton)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favButton.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor,
                                               constant: 10),
            favButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -20),
            favButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        favButton.setTitleColor(UIColor.blue, for: .normal)
        favButton.addTarget(self,
                            action: #selector(tapFav),
                            for: .touchUpInside)
    }
    
    @objc func tapFav() {
        delegate?.tapFavorite()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
