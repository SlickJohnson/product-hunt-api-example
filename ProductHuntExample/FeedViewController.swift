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

  var posts: [Post]? {
    didSet {
      feedTableView.reloadData()
    }
  }

  /// Handles requests to Product Hunt API.
  var networkManager: NetworkManager!

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
    networkManager.getPosts() { result in
      self.posts = result
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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let posts = posts else {
      return
    }
    let post = posts[indexPath.row]

    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    var commentsView = storyboard.instantiateViewController(withIdentifier: "commentsView") as? CommentsTableViewController
    commentsView?.comments = ["Blah blah blah", "Wow, ok.", "How to use?"]
    navigationController?.pushViewController(commentsView!, animated: true)
  }
}
