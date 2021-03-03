//
//  FavoritesEntity+CoreDataProperties.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//
//

import Foundation
import CoreData


extension FavoritesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesEntity> {
        return NSFetchRequest<FavoritesEntity>(entityName: "FavoritesEntity")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var userid: Int16

}

extension FavoritesEntity : Identifiable {

}
