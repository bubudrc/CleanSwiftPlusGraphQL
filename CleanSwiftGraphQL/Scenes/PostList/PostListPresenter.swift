//
//  PostListPresenter.swift
//  CleanSwiftGraphQL
//
//  Created by Marcelo Perretta on 5/2/17.
//  Copyright (c) 2017 Marcelo Perretta. All rights reserved.
//

import UIKit

protocol PostListPresenterInput {
    func presentPosts(response: PostListResponse)
    func presentVotedPostSuccess(success: Bool)
}

protocol PostListPresenterOutput: class {
    func displayPosts(viewModel: PostListViewModel)
    func displaySuccessMessage(message: String)
    func displayErrorMessage(message: String)
}

class PostListPresenter: PostListPresenterInput {
    weak var output: PostListPresenterOutput!

    // MARK: Presentation logic

    func presentPosts(response: PostListResponse) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        var displayedPosts: [PostListViewModel.DisplayedPost] = []
        
        for post in response.allPostData! {
            let postDetail: PostDetails = post.fragments.postDetails
            
            let postId: Int = postDetail.id 
            let titlePost: String = postDetail.title ?? ""
            let bylinePost: String = byline(for: postDetail) ?? ""
            let votes: String = "\(postDetail.votes ?? 0) votes"
            
            let displayedPostsModel = PostListViewModel.DisplayedPost(postId: postId, title: titlePost, author: bylinePost, votes: votes)
            displayedPosts.append(displayedPostsModel)
        }

        let viewModel = PostListViewModel(displayedPosts: displayedPosts)
        output.displayPosts(viewModel: viewModel)
    }
    
    func presentVotedPostSuccess(success: Bool) {
        if success {
            output.displaySuccessMessage(message: "Voted success")
        } else {
            output.displayErrorMessage(message: "Voted Fails")
        }
    }
    
    // We can define helper methods that take the generated data types as arguments
    private func byline(for post: PostDetails) -> String? {
        if let author = post.author {
            return "by \([author.firstName, author.lastName].flatMap { $0 }.joined(separator: " "))"
        } else {
            return nil
        }
    }
}
