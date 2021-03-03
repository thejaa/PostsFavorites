//
//  PostViewModel.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation
import Alamofire

protocol PostsDelegate {
    func updatePosts(data:PostsData?)
}

class PostViewModel {
    var delegate : PostsDelegate?
    var networkAdaptor : NetworkAdaptor
    private let manager = PostsManager()
    private let favmanager = FavoritesManager()
    
    init(_networkAdaptor : NetworkAdaptor = NetworkAdaptor()) {
        networkAdaptor = _networkAdaptor
    }
    
    func getPostData(){
        networkAdaptor.getPosts { [weak self] result in
            switch result{
            case .success(let model):
                self?.delegate?.updatePosts(data: model)
                self?.saveIntoCoreData(data: model)
                break
            case .failure(_):
                break
            }
        }
    }
    fileprivate func saveIntoCoreData(data : [PostModel]?){
        data?.forEach({ (data) in
            let post = Posts()
            post.body = data.body
            post.id = data.id
            post.title = data.title
            post.userID = data.userID
            manager.create(post: post)
        })
    }
    func fetchRecords() -> [Posts]?{
        let results = manager.fetchPostRecords()
        return results
    }
    func addToFavorites(data : Posts){
        favmanager.create(post: data)
    }
    func isAddedToFavorite(data : Posts) -> Bool{
       let value = favmanager.fetchPostById(by: data)
        if value != nil{
            return true
        }
        return false
    }
}
