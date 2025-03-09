//
//  PaymentViewController.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import UIKit

protocol PaymentViewControllerProtocol {
    
}

final class PaymentViewController: UIViewController, PaymentViewControllerProtocol {

    // MARK: - Public Properties
    
    var interactor: PaymentInteractorProtocol!
    var totalView: TotalView!
    
    // MARK: - Private properties
    
    private let payView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let panField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
   
    private let termField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let cvvField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nameField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация об оплате"
        view.backgroundColor = .systemBackground
        addCloseButton()
        view.addSubview(payView)
        payView.addSubview(panField)
        view.addSubview(totalView)
        totalView.nextBtn.setTitle("Оплатить", for: .normal)
        setConstraints()
    }

    // MARK: Private properties
    
    private func addCloseButton() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            payView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            payView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            payView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            payView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            payView.bottomAnchor.constraint(equalTo: payView.topAnchor, constant: 300),
            
            totalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalView.topAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -80),
            
            panField.topAnchor.constraint(equalTo: payView.topAnchor, constant: 16),
            panField.leadingAnchor.constraint(equalTo: payView.leadingAnchor, constant: 24),
            panField.trailingAnchor.constraint(equalTo: payView.trailingAnchor, constant: -24),
            panField.bottomAnchor.constraint(equalTo: payView.topAnchor, constant: 50)
            
        ])
    }
}
