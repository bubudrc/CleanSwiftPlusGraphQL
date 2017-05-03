//
//  PostListVC.swift
//  CleanSwiftGraphQL
//
//  Created by Marcelo Perretta on 5/2/17.
//  Copyright (c) 2017 Marcelo Perretta. All rights reserved.
//

import UIKit

protocol PostListVCInput {
    func displayPosts(viewModel: PostListViewModel)
    func displaySuccessMessage(message: String)
    func displayErrorMessage(message: String)
}

protocol PostListVCOutput {
    func fetchAllPost()
    func userWanToVotePost(postID: Int)
}

class PostListVC: UITableViewController, PostListVCInput, PostTableViewCellDelegate {
    var output: PostListVCOutput!
    var router: PostListRouter!
    
    var posts: [PostListViewModel.DisplayedPost]? {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        PostListConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 64
        
        self.output.fetchAllPost()
    }

    // MARK: Event handling

    // MARK: Display logic

    func displayPosts(viewModel: PostListViewModel) {
        // NOTE: Display the result from the Presenter

        self.posts = viewModel.displayedPosts
    }
    
    func displaySuccessMessage(message: String) {
        print("SUCCESS VOTED MSG: \(message)")
    }
    
    func displayErrorMessage(message: String) {
        print("FAIL VOTED MSG: \(message)")
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostTableViewCell else {
            fatalError("Could not dequeue PostTableViewCell")
        }
        
        guard let post = posts?[indexPath.row] else {
            fatalError("Could not find post at row \(indexPath.row)")
        }
        
        cell.configure(with: post)
        cell.cellDelegate = self
        
        return cell
    }
    
    // MARK: PostTableViewCellDelegate
    func userVotedPost(_ postID: Int) {
        output.userWanToVotePost(postID: postID)
    }

}
