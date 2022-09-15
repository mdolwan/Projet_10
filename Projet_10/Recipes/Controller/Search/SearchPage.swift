//
//  SearchPage.swift
//  Recipes
//
//  Created by Mohammad Olwan on 12/03/2022.
//

import UIKit

class SearchPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var tasksTableView: UITableView! { didSet { tasksTableView.tableFooterView = UIView() } }
    
    @IBOutlet weak var stackViewTop: UIStackView!
    @IBOutlet weak var ingredientTypedTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var ingredientTableView: UITableView!
    
    var recipe : RequestService = RequestService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - To hide title of BackButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        ingredientTypedTextField.delegate = self
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        
        // MARK: - Func for hide keyboard
        initializeHideKeyboard()
    }
    
    // MARK: - For add the ingredient within the textField in Array
    @IBAction func addBtn(_ sender: UIButton) {
        
        
        var alimentair = ingredientTypedTextField.text
         alimentair = alimentair!.trimmingCharacters(in: .whitespacesAndNewlines)
        if ingredientTypedTextField.text?.isEmpty == true || alimentair?.isEmpty == true {
           return }
        RequestService.TermSearched.append(alimentair!)
        ingredientTypedTextField.text = nil
        ingredientTableView.reloadData()
        if ingredientTableView.numberOfRows(inSection: 0) != 0 {
            searchButton.isEnabled = true
        }
        else {
            searchButton.isEnabled = false
        }
        view.endEditing(true)
    }
    
    // MARK: - For empty all components
    @IBAction func ClearAll(_ sender: Any) {
        RequestService.TermSearched.removeAll()
        ingredientTableView.reloadData()
        ingredientTypedTextField.text = ""
        searchButton.isEnabled = false
        view.endEditing(true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestService.TermSearched.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = "- " + RequestService.TermSearched[indexPath.row]
        cell.textLabel?.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
}


extension SearchPage: UITextFieldDelegate{
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}


