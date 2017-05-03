//
//  PostListInteractor.swift
//  CleanSwiftGraphQL
//
//  Created by Marcelo Perretta on 5/2/17.
//  Copyright (c) 2017 Marcelo Perretta. All rights reserved.
//

import UIKit

protocol PostListInteractorInput {
    func fetchAllPost()
    func userWanToVotePost(postID: Int)
}

protocol PostListInteractorOutput {
    func presentPosts(response: PostListResponse)
    func presentVotedPostSuccess(success: Bool)
}

class PostListInteractor: PostListInteractorInput {
    var output: PostListInteractorOutput!
    var worker: PostListWorkerProtocol = PostListWorker()

    // MARK: Business logic

    func fetchAllPost() {
        // NOTE: Create some Worker to do the work
        worker.getPosts(success: { (posts: [AllPostsQuery.Data.Post]?) in
            
            // NOTE: Pass the result to the Presenter
            let response = PostListResponse(allPostData: posts)
            self.output.presentPosts(response: response)
        })
    }
    
    func userWanToVotePost(postID: Int) {
        worker.votePost(postID: postID, success: { (successResponse: Bool) in
            // NOTE: Pass the result to the Presenter
            self.output.presentVotedPostSuccess(success: successResponse)
        })
    }

}
