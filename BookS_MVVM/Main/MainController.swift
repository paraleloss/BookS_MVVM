//
//  ViewController.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 08/03/22.
//

import UIKit
import CoreData

class MainController: UIViewController {
    private(set) var managedObjectContext: NSManagedObjectContext
    let splashView = SplashView()
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashView.animateView {
            self.initialController()
        }
    }
    
    private func initialController() {
        if existSession() {
            showHomeController()
        } else {
            let signInController = SignInViewController(context: managedObjectContext)
            signInController.modalPresentationStyle = .fullScreen
            signInController.delegate = self
            present(signInController, animated: false)
        }
    }
    
    private func existSession() -> Bool {
        guard let _ = UserDefaults.standard.object(forKey: "username"),
              let _ = UserDefaults.standard.object(forKey: "password") else {
                  return false
              }
        return true
    }
    
    private func showHomeController() {
        let tabBar = TabBarController(context: managedObjectContext)
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(splashView)
        splashView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            splashView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            splashView.heightAnchor.constraint(equalToConstant: 200),
            splashView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainController: SignInDelegate {
    func signInComplete() {
        showHomeController()
    }
}

