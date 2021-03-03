//
//  PostsManager.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation

class PostsManager{
    private let _postsRepository : PostsDataRepository = PostsDataRepository()
    
    func create(post : Posts){
        _postsRepository.insertRecords(posts: post)
    }
    
    func fetchPostRecords() -> [Posts]?{
        return _postsRepository.fetchRecords()
    }
    
    func fetchPostById(by post : Posts) -> Posts?{
        return _postsRepository.postsById(post: post)
    }
}
