//
//  FavoriteEnityExtension.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation

extension FavoritesEntity{
    func convertToFav()-> Posts{
        let post = Posts()
        post.id = Int(self.id)
        post.body = self.body
        post.title = self.title
        post.userID = Int(self.userid)
        return post
    }
}
