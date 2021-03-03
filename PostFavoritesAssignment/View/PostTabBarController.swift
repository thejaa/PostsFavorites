//
//  PostTabBarController.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import UIKit
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class PostTabBarController: UIViewController {
    
    @IBOutlet weak var postTableView : UITableView!
    var viewModel = PostViewModel()
    var dataSource = [PostModel]()
    var offlinePost = [Posts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Posts"

        postTableView.dataSource = self
        postTableView.delegate = self
       // postTableView.estimatedRowHeight = 120
        print(applicationDirectoryPath())
    }
    //Get Directorypath
    func applicationDirectoryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String
    }
    override func viewWillAppear(_ animated: Bool) {
        if Connectivity.isConnectedToInternet{
            if PersistanceStorage.shared.delete(managedObject: PostsEntity.self){
                viewModel.getPostData()
            }
            viewModel.delegate = self
        }else{
            guard let value = viewModel.fetchRecords() else {return}
            offlinePost = value
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
    }
}
extension PostTabBarController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Connectivity.isConnectedToInternet == true ? dataSource.count : offlinePost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        cell.title.text = Connectivity.isConnectedToInternet == true ? dataSource[indexPath.row].title : offlinePost[indexPath.row].title
        cell.descriptionTextView.isUserInteractionEnabled = false
        cell.descriptionTextView.text = Connectivity.isConnectedToInternet == true ? dataSource[indexPath.row].body :  offlinePost[indexPath.row].body
        return cell
    }
}
extension PostTabBarController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if Connectivity.isConnectedToInternet{
            let data = Posts()
            data.body = dataSource[indexPath.row].body
            data.title = dataSource[indexPath.row].title
            data.id = dataSource[indexPath.row].id
            data.userID = dataSource[indexPath.row].userID
            if viewModel.isAddedToFavorite(data: data){
                showToast(message: "Already added as favorites", font: .systemFont(ofSize: 12))
            }else{
                viewModel.addToFavorites(data: data)
                showToast(message: "Post added to favorites", font: .systemFont(ofSize: 12))
            }
            
        }else{
            viewModel.addToFavorites(data: offlinePost[indexPath.row])
        }
    }
}
extension PostTabBarController: PostsDelegate {
    func updatePosts(data: PostsData?) {
        guard let dataCallBack = data else {return}
        dataSource = dataCallBack
        self.postTableView.reloadData()
    }
}
