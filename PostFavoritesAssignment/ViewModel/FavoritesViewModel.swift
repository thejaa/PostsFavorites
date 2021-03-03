//
//  FavoritesViewModel.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation

class FavoritesViewModel {
  
    private let favmanager = FavoritesManager()
    typealias GetFavCompletion = (_ result : [Posts]) -> Void
    
    init() {}
    //completion : @escaping GetFavCompletion
    func fetchRecords() -> [Posts]?{
        let results = favmanager.fetchPostRecords()
        return results
    }
    func isAddedToFavorite(data : Posts) -> Bool{
       let value = favmanager.fetchPostById(by: data)
        if value != nil{
            return true
        }
        return false
    }
    
    func removedFavoriteBy(postId : Posts) -> Bool{
        let value = favmanager.removeFavById(by: postId)
        return value
    }
}
