//
//  ViewController.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 08/03/22.
//

import UIKit

class MainController: UIViewController {
    
    let splashView = SplashView()
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashView.animateView {
            //self.initialController()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
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
    

}

