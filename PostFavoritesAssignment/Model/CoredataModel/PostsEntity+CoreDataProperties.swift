//
//  PostsEntity+CoreDataProperties.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//
//

import Foundation
import CoreData


extension PostsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostsEntity> {
        return NSFetchRequest<PostsEntity>(entityName: "PostsEntity")
    }

    @NSManaged public var userid: Int16
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension PostsEntity : Identifiable {

}
