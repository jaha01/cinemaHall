//
//  PaymentViewController.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import UIKit

protocol PaymentViewControllerProtocol {
    func updateTotalView(price: Int) 
}

final class PaymentViewController: UIViewController, PaymentViewControllerProtocol, TotalViewDelegate {

    // MARK: - Public Properties
    
    var interactor: PaymentInteractorProtocol!
    
    // MARK: - Private properties
    
    private let totalView = TotalView()
    
    private let payView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var panField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 18
        textField.placeholder = "Номер карты"
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.size.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
   
    private lazy var expiryField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 18
        textField.placeholder = "Срок"
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.size.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var cvvField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 18
        textField.placeholder = "CVV"
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.size.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 18
        textField.placeholder = "Фамилия и Имя"
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.delegate = self
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.size.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 18
        textField.placeholder = "Email"
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.delegate = self
        textField.keyboardType = .emailAddress
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.size.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация об оплате"
        view.backgroundColor = .systemBackground
        addCloseButton()
        view.addSubview(payView)
        view.addSubview(totalView)
        payView.addSubview(panField)
        payView.addSubview(expiryField)
        payView.addSubview(cvvField)
        payView.addSubview(nameField)
        payView.addSubview(emailField)
        totalView.delegate = self
        setConstraints()
        interactor.loadData()
        
    }

    // MARK: - Public methods
    
    func updateTotalView(price: Int) {
        totalView.configure(price: price, bntName: "Оплатить")
    }
    
    func didTapNextBtn() { // MARK: - кнопка не нажимается после того как кликнул хотя бы на один textField
        if Validator.isValidEmail(for: emailField.text!) {
            emailField.animateError()
            return
        }

        if Validator.isValidName(for: nameField.text!) {
            nameField.animateError()
            return
        }
        if let pan = panField.text, !pan.isEmpty,
           let expiry = expiryField.text, !expiry.isEmpty,
           let cvv = cvvField.text, !cvv.isEmpty,
           let name = nameField.text, !name.isEmpty,
           let email = emailField.text, !email.isEmpty  {
            showAlert(withTitle: "Успех", message: "На указанный вами Email отправлены билеты и чек")
        }
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
            payView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            payView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            payView.bottomAnchor.constraint(equalTo: payView.topAnchor, constant: 300),
            
            totalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 80),
            
            panField.topAnchor.constraint(equalTo: payView.topAnchor, constant: 20),
            panField.leadingAnchor.constraint(equalTo: payView.leadingAnchor, constant: 24),
            panField.trailingAnchor.constraint(equalTo: payView.trailingAnchor, constant: -24),
            panField.heightAnchor.constraint(equalToConstant: 40),
            
            expiryField.topAnchor.constraint(equalTo: panField.bottomAnchor, constant: 20),
            expiryField.leadingAnchor.constraint(equalTo: panField.leadingAnchor),
            expiryField.trailingAnchor.constraint(equalTo: expiryField.leadingAnchor, constant: 100),
            expiryField.heightAnchor.constraint(equalTo: panField.heightAnchor),

            cvvField.topAnchor.constraint(equalTo: expiryField.topAnchor),
            cvvField.trailingAnchor.constraint(equalTo: panField.trailingAnchor),
            cvvField.leadingAnchor.constraint(equalTo: cvvField.trailingAnchor, constant: -100),
            cvvField.heightAnchor.constraint(equalTo: panField.heightAnchor),
            
            nameField.topAnchor.constraint(equalTo: expiryField.bottomAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: panField.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: panField.trailingAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 40),
            
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: panField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: panField.trailingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            
            
        ])
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.closeButtonTapped()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}



extension PaymentViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
             return true
         }
        
        if textField == cvvField {
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            return newLength <= 4 && string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        }
        
        if textField == panField {
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            return newLength <= 16 && string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        }
        
        if textField == expiryField {
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            let formattedText = formatExpiryText(currentText + string)

            if newLength <= 5 && string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                textField.text = formattedText
                return false
            }
            return false
        }

        return true
    }

    func formatExpiryText(_ text: String) -> String {
        let cleanText = text.replacingOccurrences(of: "/", with: "")
        var formattedText = ""
        
        for (index, character) in cleanText.enumerated() {
            if index == 2 {
                formattedText.append("/") // Вставляем / после 2 символа
            }
            formattedText.append(character)
        }
        
        return formattedText
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
