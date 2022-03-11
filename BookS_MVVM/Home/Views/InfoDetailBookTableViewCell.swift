//
//  InfoDetailBookTableViewCell.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit

class InfoDetailBookTableViewCell: UITableViewCell {
    let infoLabel = UILabel()
    
    var book: DetailBook? {didSet{
        guard let book = book else {
            return
        }
        infoLabel.text = book.description
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
        ])
        infoLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
