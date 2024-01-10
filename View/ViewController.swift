//
//  ViewController.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 09-01-24.
//

import UIKit

class ViewController: UIViewController {
   
    private var articleListVM: ArticleListViewModel!
    
    var listMenus = [Article]()
    var searching = false
    var searchedMenu =  [Article]()
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - IBOutlets
    lazy var tableView: UITableView = {
        let table: UITableView = .init()
        table.delegate = self
        table.dataSource = self
        table.register(ArticleTableNewViewCell.self, forCellReuseIdentifier: "ArticleTableNewViewCell")
        table.rowHeight = 150.0
        table.separatorColor = UIColor.orange
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpTableView()
        setup()
        configureSearchController()
    }
    func configureSearchController() {
           searchController.loadViewIfNeeded()
           searchController.searchResultsUpdater = self
           searchController.searchBar.delegate = self
           searchController.obscuresBackgroundDuringPresentation = false
           searchController.searchBar.enablesReturnKeyAutomatically = false
           searchController.searchBar.returnKeyType = UIReturnKeyType.done
           self.navigationItem.searchController = searchController
           self.navigationItem.hidesSearchBarWhenScrolling = false
           definesPresentationContext = true
           searchController.searchBar.placeholder = "Buscar por nombre"
           searchController.searchBar.tintColor = .white
           searchController.searchBar.backgroundColor = .white
       }
    private func setUpTableView() {
         view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant:  35.0).isActive = true
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
     }
    
    private func setup() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        Webservice().getArticles() { articles in
            
            if let articles = articles {
                
                self.articleListVM = ArticleListViewModel(articles: articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
}
extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
        func updateSearchResults(for searchController: UISearchController) {
            guard let searchText = searchController.searchBar.text else { return }
            searchedMenu = listMenus.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            searching = !searchText.isEmpty
            tableView.reloadData()
        }
        // MARK: - UISearchBarDelegate
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            searchedMenu.removeAll()
            tableView.reloadData()
        }
}

extension ViewController:  UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//       return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
//   }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return self.articleListVM.numberOfRowsInSection(section)
//   }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return searching ? 1 : self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return searching ? searchedMenu.count : self.articleListVM.numberOfRowsInSection(section)
       }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableNewViewCell", for: indexPath) as? ArticleTableNewViewCell else {
           fatalError("ArticleTableNewViewCell not found")
       }
           if searching {
            let article: Article
                article = searchedMenu[indexPath.row]
            let articleModels = ArticleTableNewModel(title: article.title, desc: article.description ?? "", imageURL: "")
            cell.configure(articleModels)
            } else {
                let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
                 let articleModel = ArticleTableNewModel(title: articleVM.title, desc: articleVM.description, imageURL: "")
                 cell.configure(articleModel)
            }
    
       
       return cell
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
   }
   
}


