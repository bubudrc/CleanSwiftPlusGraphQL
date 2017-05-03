//
//  PostListModels.swift
//  CleanSwiftGraphQL
//
//  Created by Marcelo Perretta on 5/2/17.
//  Copyright (c) 2017 Marcelo Perretta. All rights reserved.
//

import UIKit

struct PostListRequest {}

struct PostListResponse {

    var allPostData: [AllPostsQuery.Data.Post]?
}

struct PostListViewModel {

    struct DisplayedPost {
        var postId: Int?
        var title: String?
        var author: String?
        var votes: String?
    }
    
    var displayedPosts: [DisplayedPost]

}
