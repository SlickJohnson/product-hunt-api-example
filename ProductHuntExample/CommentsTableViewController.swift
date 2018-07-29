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

  override func viewDidLoad() {
    super.viewDidLoad()
    commentsTableView.dataSource = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}


// MARK: UITableViewDatasource
extension CommentsTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
