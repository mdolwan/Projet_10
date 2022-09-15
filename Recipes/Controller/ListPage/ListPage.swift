//
//  ListPageVC.swift
//  Recipes
//
//  Created by Mohammad Olwan on 13/03/2022.
//

import UIKit

class ListPage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    var repository : RequestService = RequestService()
    var hits: [Hit] = []
    var links: String? //= ""
    let listEmptyLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        
        // MARK: - First demande of API
        repository.getRecipe(Pagination: false, getUrl: "", callback: {
            [self] result in
            switch result {
            case .success(let recipe):
                self.hits = recipe.hits
                if recipe.hits.count == 0 {
                    createLabel()
                    return
                }
                self.links = (recipe.links.next?.href!)
                recipeTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //createLabel()
        return self.hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfList", for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        let recipe = self.hits[indexPath.row].recipe
        cell.configure(with: recipe)
        cell.textLabel?.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            hits.remove(at: indexPath.row)
            self.recipeTableView.deleteRows(at: [indexPath], with: .fade)
            recipeTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewContrller = storyboard?.instantiateViewController(withIdentifier: "DetailedRecipe") as! DetailOfRecipePage
        detailViewContrller.hitSelected = hits[indexPath.row]
        self.navigationController?.pushViewController(detailViewContrller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}


extension ListPage: UIScrollViewDelegate {
    
    // MARK: - Create Footer with ActivityIndicator
    private func createSpinnerFooter() -> UIView {
        
        let footerView = UIView(frame: CGRect (x: 0, y: 0, width: view.frame.size.width, height:100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.color = UIColor.white
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    // MARK: - Function for Traite The Pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard !repository.isPagination else{
            return
        }
        let position = scrollView.contentOffset.y
        if recipeTableView.contentSize.height == 0 { return }
        if position > (recipeTableView.contentSize.height - scrollView.frame.size.height)
        {
            if links!.isEmpty {
                return
            }
            
            self.recipeTableView.tableFooterView = createSpinnerFooter()
            repository.getRecipe(Pagination: true, getUrl: links!, callback: { [weak self] resultPlus in
                
                self?.recipeTableView.tableFooterView = nil
                
                switch resultPlus {
                case .success(let recipePlus):
                    self?.hits.append(contentsOf: recipePlus.hits)
                    if ((recipePlus.links.next?.href?.isEmpty) == nil) {
                        self?.links = ""
                    }else {
                        self?.links = (recipePlus.links.next?.href!)!
                    }
                    DispatchQueue.main.async {
                        self?.recipeTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }else{
            return
        }
    }
}

extension ListPage {
    
    // MARK: - To indicate that there are no recipe in favorite
    func createLabel(){
        if self.hits.count == 0 {
            listEmptyLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 100)
            listEmptyLabel.text = "There are no recipe in your search.\("\n") Try another ingredient"
            listEmptyLabel.numberOfLines = 0
            listEmptyLabel.center = self.view.center
            listEmptyLabel.textAlignment = .center
            listEmptyLabel.backgroundColor = UIColor.black
            listEmptyLabel.textColor = UIColor.white
            self.view.addSubview(listEmptyLabel)
        }
        else{
            listEmptyLabel.removeFromSuperview()
        }
    }
}



