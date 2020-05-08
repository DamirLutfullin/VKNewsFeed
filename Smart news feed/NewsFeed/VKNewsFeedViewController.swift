//
//  VKNewsFeedViewController.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol VKNewsFeedDisplayLogic: class {
  func displayData(viewModel: VKNewsFeed.Model.ViewModel.ViewModelData)
}

class VKNewsFeedViewController: UIViewController, VKNewsFeedDisplayLogic {

  var interactor: VKNewsFeedBusinessLogic?
  var router: (NSObjectProtocol & VKNewsFeedRoutingLogic)?
    private var feedViewModel = FeedViewModel(cells: [])
    

    @IBOutlet var table: UITableView!
    
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = VKNewsFeedInteractor()
    let presenter             = VKNewsFeedPresenter()
    let router                = VKNewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    table.register(UINib(nibName: "VKNewsFeedCell", bundle: nil), forCellReuseIdentifier: VKNewsFeedCell.reuseId)
    interactor?.makeRequest(request: .getNewsFeed)

  }
  
  func displayData(viewModel: VKNewsFeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayNewsFeed(feedViewModel: let feedViewModel):
        self.feedViewModel = feedViewModel
        table.reloadData()
    }
  }
}

extension VKNewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VKNewsFeedCell.reuseId, for: indexPath) as! VKNewsFeedCell
        cell.set(viewModel: feedViewModel.cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 312
    }
    
    
}