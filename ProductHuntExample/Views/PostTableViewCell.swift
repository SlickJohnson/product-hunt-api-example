//
//  PostTableViewCell.swift
//  ProductHuntExample
//
//  Created by Willie Johnson on 6/29/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var taglineLabel: UILabel!
  @IBOutlet weak var commentsCountLabel: UILabel!
  @IBOutlet weak var votesCountLabel: UILabel!
  @IBOutlet weak var previewImageView: UIImageView!

  var post: Post? {
    didSet {
      guard let post = post else { return }
      nameLabel.text = post.name
      taglineLabel.text = post.tagline
      commentsCountLabel.text = "Comments: \(post.commentsCount)"
      votesCountLabel.text = "Votes: \(post.votesCount)"
      updatePreviewImage()
    }
  }

  func updatePreviewImage() {
    guard let post = post else { return }
    previewImageView.image = UIImage(named: "placeholder")
  }
}
