//
//  FavoritesTabBarController.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import UIKit

class FavoritesTabBarController: UIViewController {
    
    @IBOutlet weak var favoritesTableView : UITableView!
    var dataSource = [Posts]()
    private var viewModel = FavoritesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        print("FavoritesTabBarController")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchData()
    }
}
extension FavoritesTabBarController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        cell.title.text = dataSource[indexPath.row].title
        cell.descriptionTextView.isUserInteractionEnabled = false
        cell.descriptionTextView.text = dataSource[indexPath.row].body
        return cell
    }
}
extension FavoritesTabBarController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = viewModel.removedFavoriteBy(postId: dataSource[indexPath.row])
        fetchData()
        showToast(message: "Removed from favorites", font: .systemFont(ofSize: 12))
    }
}
extension FavoritesTabBarController{
    private func fetchData(){
        dataSource = viewModel.fetchRecords() ?? []
        DispatchQueue.main.async {
            self.favoritesTableView.reloadData()
        }
    }
}
