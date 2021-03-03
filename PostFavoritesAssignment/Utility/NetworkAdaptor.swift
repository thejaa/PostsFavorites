//
//  NetworkAdaptor.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation
import Alamofire

enum GetPostFailureReason:String,Error{
    case notFound = "Invalid Request"
}

class NetworkAdaptor{
    typealias GetPostResults = Result<PostsData,GetPostFailureReason>
    typealias GetPostsCompletion = (_ result : GetPostResults) -> Void
    
    func getPosts(completion: @escaping GetPostsCompletion) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        AF.request(url).responseJSON { response in
            if let responseData = response.data{
                do{
                    let decoder = JSONDecoder()
                        let model = try decoder.decode(PostsData.self, from:
                                                        responseData) //Decode JSON Response Data
                    //print(model)
                     completion(.success(model))
                }catch let error{
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
