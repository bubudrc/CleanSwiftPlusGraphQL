//
//  PostListConfigurator.swift
//  CleanSwiftGraphQL
//
//  Created by Marcelo Perretta on 5/2/17.
//  Copyright (c) 2017 Marcelo Perretta. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension PostListVC: PostListPresenterOutput {
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension PostListInteractor: PostListVCOutput {}

extension PostListPresenter: PostListInteractorOutput {}

class PostListConfigurator {

    // MARK: Object lifecycle

    static var sharedInstance = PostListConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: PostListVC) {
        let router = PostListRouter()
        router.viewController = viewController

        let presenter = PostListPresenter()
        presenter.output = viewController

        let interactor = PostListInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
