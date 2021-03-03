//
//  PostBaseRepository.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation


protocol PostBaseRepository{
    associatedtype T
    func insertRecords(posts:T)
    func fetchRecords() -> [T]?
    func postsById(post byId:T)->T?
}
