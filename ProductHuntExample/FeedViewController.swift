//
//  FeedViewController.swift
//  ProductHuntExample
//
//  Created by Willie Johnson on 6/27/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

/// Main screen of the app which shows the product feed.
class FeedViewController: UIViewController {
  /// Displays the currently featured posts on Product Hunt.
  @IBOutlet weak var feedTableView: UITableView!

  /// Handles requests to Product Hunt API.
  var networkManager: NetworkManager!
  var posts: [Post]? {
    didSet {
      DispatchQueue.main.async { [unowned self] in
        self.feedTableView.reloadData()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    feedTableView.dataSource = self
    feedTableView.delegate = self
    networkManager = NetworkManager()
    updateFeed()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func updateFeed() {
    DispatchQueue.global().async { [unowned self] in
      self.networkManager.getPosts() { result in
        self.posts = result
      }
    }
  }
}

// MARK: UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let posts = posts else { return 0 }
    return posts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let posts = posts, let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as? PostTableViewCell else {
      return UITableViewCell()
    }
    let post = posts[indexPath.row]
    cell.post = post
    return cell
  }
}

// MARK: UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250
  }
}
