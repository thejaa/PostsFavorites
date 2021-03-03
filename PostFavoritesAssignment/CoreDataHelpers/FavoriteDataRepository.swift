//
//  FavoriteDataRepository.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation
import CoreData

protocol FavoritesRepository : PostBaseRepository {
}

class FavoriteDataRepository : FavoritesRepository {
    
    func postsById(post byId: Posts) -> Posts? {
        let result = self.fetchByID(by: byId)
        guard result != nil else {return nil}
        return result!.convertToFav()
    }
    
    func removeFromFavorite(post by : Posts) -> Bool{
        guard let result = self.removeByID(by: by) else {return false}
        return result
    }
    
    func insertRecords(posts: Posts) {
        let record = FavoritesEntity(context: PersistanceStorage.shared.context)
        record.id = Int16(posts.id ?? 0)
        record.title = posts.title
        record.body = posts.body
        record.userid = Int16(posts.userID ?? 0)
        
        PersistanceStorage.shared.saveContext()
    }
    
    func fetchRecords() -> [Posts]? {
             let result = PersistanceStorage.shared.fetchRequests(managedObject: FavoritesEntity.self)
        guard result != nil && result?.count != 0 else {return nil}
        var records : [Posts] = []
        result?.forEach({ post in
            records.append(post.convertToFav())
        })
        return records
    }
        
    private func fetchByID(by id : Posts) -> FavoritesEntity?{
        let fetchRequest = NSFetchRequest<FavoritesEntity>(entityName: "FavoritesEntity")
        let fetchById = NSPredicate(format: "id==%i", id.id ?? 0 )
        fetchRequest.predicate = fetchById
        let result = try! PersistanceStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}
        return result.first
    }
    
    private func removeByID(by id : Posts) -> Bool?{
        let fetchRequest = NSFetchRequest<FavoritesEntity>(entityName: "FavoritesEntity")
        let fetchById = NSPredicate(format: "id==%i", id.id ?? 0 )
        fetchRequest.predicate = fetchById
        let result = try! PersistanceStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return false}
        PersistanceStorage.shared.context.delete(result.first!)
        PersistanceStorage.shared.saveContext()
        return true
    }
    
    typealias T = Posts
    
    
}
