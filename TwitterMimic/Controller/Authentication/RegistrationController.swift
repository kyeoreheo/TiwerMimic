//
//  LoginController.swift
//  TwitterMimic
//
//  Created by Kyo on 3/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    // MARK: - Propertries
    
    private let imagePicker = UIImagePickerController()
    private var profileImage = UIImage(named: "avatar")
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "addPhoto"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "mail")
        let view = CustomView().inputContainerView(withImage: image, textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
       
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "lock")
        let view = CustomView().inputContainerView(withImage: image, textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "mail")
        let view = CustomView().inputContainerView(withImage: image, textField: fullnameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
       
    private lazy var usernameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "lock")
        let view = CustomView().inputContainerView(withImage: image, textField: usernameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
   
    private let emailTextField: UITextField = {
        let textField = CustomView().textField(withPlaceholder: "Email")
        return textField
    }()
   
    private let passwordTextField: UITextField = {
        let textField = CustomView().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let fullnameTextField: UITextField = {
       let textField = CustomView().textField(withPlaceholder: "Full Name")
       return textField
    }()
      
    private let usernameTextField: UITextField = {
       let textField = CustomView().textField(withPlaceholder: "Username")
       return textField
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = CustomView().attributedButton("Already have an account? ", " Log In")
        button.addTarget(self, action: #selector(showLogIn), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.logoBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Selector
    @objc
    func showLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func signUp() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text,
              let username = usernameTextField.text?.lowercased(),
              let profileImage = profileImage
        else { return }
        
        let user = AuthProperties(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)

        AuthService.shared.registerUser(user: user) { (error, ref) in
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                  let mainView = window.rootViewController as? MainTabController
            else { return }

            mainView.autenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    func addPhoto() {
        present(imagePicker, animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .logoBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        addPhotoButton.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingBottom: 16, paddingRight: 40)
    }
}


// MARK: - Extension

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info [.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        addPhotoButton.layer.cornerRadius = 150 / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        
        
        self.addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
