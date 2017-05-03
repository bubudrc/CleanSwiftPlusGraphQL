//
//  PostListWorker.swift
//  CleanSwiftGraphQL
//
//  Created by Marcelo Perretta on 5/2/17.
//  Copyright (c) 2017 Marcelo Perretta. All rights reserved.
//

import UIKit
import Apollo

protocol PostListWorkerProtocol {
    func getPosts(success: @escaping ([AllPostsQuery.Data.Post]?) -> ())
    func votePost(postID: Int, success: @escaping (Bool) -> ())
}

class PostListWorker: PostListWorkerProtocol {
    
    // MARK: Business Logic
    func getPosts(success: @escaping ([AllPostsQuery.Data.Post]?) -> ()) {
        
        //apollo.fetch(query: AllPostsQuery()) { (result, error) in ... ONLY GIVE US THE DATA, BUT WE CAN'T INTERACT WITH THEM
        
        let _: GraphQLQueryWatcher<AllPostsQuery>? = apollo.watch(query: AllPostsQuery()) { (result, error) in
            if let error = error { NSLog("Error while fetching query: \(error.localizedDescription)");  return }
            guard let result = result else { NSLog("No query result");  return }
            
            if let errors = result.errors {
                NSLog("Errors in query result: \(errors)")
            }
            
            guard let data = result.data else { NSLog("No query result data");  return }

            success(data.posts)
        }
    }
    
    func votePost(postID: Int, success: @escaping (Bool) -> ()) {
        apollo.perform(mutation: UpvotePostMutation(postId: postID)) { (result, error) in
            if let error = error {
                NSLog("Error while attempting to upvote post: \(error.localizedDescription)")
                success(false)
            } else {
                success(true)
            }
        }
    }
}
