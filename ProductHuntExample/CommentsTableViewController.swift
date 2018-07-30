//
//  CommentsTableViewController.swift
//  ProductHuntExample
//
//  Created by Willie Johnson on 7/29/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

class CommentsTableViewController: UIViewController {
  
  @IBOutlet weak var commentsTableView: UITableView!

  var comments: [String]!

  override func viewDidLoad() {
    super.viewDidLoad()
    commentsTableView.dataSource = self
    commentsTableView.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}


// MARK: UITableViewDatasource
extension CommentsTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as? CommentTableViewCell else {
      return UITableViewCell()
    }
    let comment = comments[indexPath.row]
    cell.commentTextView.text = comment
    return cell
  }
}

// MARK: UITableViewDelegate
extension CommentsTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 125
  }
}
