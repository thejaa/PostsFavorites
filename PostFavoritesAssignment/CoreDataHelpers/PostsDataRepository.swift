//
//  PostsDataRepository.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation
import CoreData

protocol PostsRepository : PostBaseRepository {

}

class PostsDataRepository : PostsRepository {
    
    func postsById(post byId: Posts) -> Posts? {
        let result = self.fetchByID(byid: byId)
        guard result != nil else {return nil}
        return result!.convertToFav()
    }
    
    func insertRecords(posts: Posts) {
        let record = PostsEntity(context: PersistanceStorage.shared.context)
        record.id = Int16(posts.id ?? 0)
        record.title = posts.title
        record.body = posts.body
        record.userid = Int16(posts.userID ?? 0)
        
        PersistanceStorage.shared.saveContext()
    }
    
    func fetchRecords() -> [Posts]? {
             let result = PersistanceStorage.shared.fetchRequests(managedObject: PostsEntity.self)
        guard result != nil && result?.count != 0 else {return nil}
        var records : [Posts] = []
        result?.forEach({ post in
            records.append(post.convertToPost())
        })
        return records
    }
    
    private func fetchByID(byid : Posts) -> FavoritesEntity?{
        let iddd = byid.id
        let fetchRequest = NSFetchRequest<FavoritesEntity>(entityName: "FavoritesEntity")
        let fetchById = NSPredicate(format: "id==%i", iddd ?? 0)
        fetchRequest.predicate = fetchById
        let result = try! PersistanceStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}
        return result.first
    }
        
    typealias T = Posts
    
    
}
