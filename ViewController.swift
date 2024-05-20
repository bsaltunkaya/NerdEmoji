//
//  ViewController.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 5.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var nameTextField:UITextField!
    var authorTextField:UITextField!
    var genreTextField:UITextField!
    var isbnTextField:UITextField!
    var yearTextField:UITextField!
    var addButton:UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.background = .white
        setupUI()
    }
    func setupUI
    {
        nameTextField=createTextField(placeholder:"Enter book name")
        authorTextField=createTextField(placeholder:"Enter author")
        genreTextField=createTextField(placeholder:"Enter genre")
        isbnTextField=createTextField(placeholder:"Enter ISBN")
        yearTextField = createTextField(placeholder: "Enter year")

        addButton=UIButton(type: .system)
        addButton.setTitle(Add Book, for: .normal)
        addButton.addTarget(self, action: #selector(addBookToFirestore), for: .touchUpInside)
        
        let stackView=UIStackView(arrangedSubviews: [nameTextField, authorTextField, genreTextField, isbnTextField, yearTextField, addButton])
        stackView.axis=.vertical
        stackView.spacing=10
        stackview.translatesAutoresizingMaskIntoConstraints=false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.8)
        ])
    }
    func createTextField(placeholder:String)->UITextField
    {
        let textField=UITextField()
        textField.placeholder=placeholder
        textField.borderStyle=.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints=false
        return textField
    }
    @objc func addBookToFirestore(book:Book)
    {
        addBook(book: <#T##Book#>)
    }

}
