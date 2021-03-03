//
//  FavoritesManager.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation

class FavoritesManager {
    private let _favRepository : FavoriteDataRepository = FavoriteDataRepository()
    
    func create(post : Posts){
        _favRepository.insertRecords(posts: post)
    }
    
    func fetchPostRecords() -> [Posts]?{
        return _favRepository.fetchRecords()
    }
    func fetchPostById(by post : Posts) -> Posts?{
        return _favRepository.postsById(post: post)
    }
    
    func removeFavById(by post : Posts) -> Bool{
        return _favRepository.removeFromFavorite(post: post)
    }
    
}
