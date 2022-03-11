//
//  ProfileViewController.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//


import UIKit
import CoreData

protocol ProfileViewControllerDelegate: AnyObject {
    func logOutUser()
}

class ProfileViewController: UIViewController {
    weak var delegate: ProfileViewControllerDelegate?
    private(set) var managedObjectContext: NSManagedObjectContext
    let profileView = ProfileView()
    let viewModel = ProfileViewModel()
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        self.setBackgroundImage2("a", contentMode: .scaleAspectFill)
        setup()
    }
    
    private func setup() {
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        //view.backgroundColor = .red
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        profileView.delegate = self
        if let info = viewModel.getInfoUser(fromContext: managedObjectContext){
            profileView.setInfo(name: info.name,
                                image: info.image)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOut))
    }
    
    @objc func logOut() {
        delegate?.logOutUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.fillFavoritesBooks(viewModel.getFavoritesBooks(fromContext: managedObjectContext))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileViewController: ProfileViewDelegate {
    func tapFavBook(_ book: DetailBook) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(DetailBookViewController(book: book,
                                                                          context: managedObjectContext),
                                                 animated: true)
        hidesBottomBarWhenPushed = false
    }
}

