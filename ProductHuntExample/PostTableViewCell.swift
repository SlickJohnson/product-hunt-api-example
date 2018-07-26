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
  
  private var downloadedPreviewImageURL: URL?

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func updatePreviewImage() {
    guard let post = post else { return }
    previewImageView.image = #imageLiteral(resourceName: "placeholder")
//    DispatchQueue.global().async {
//      guard let data = try? Data(contentsOf: post.previewImageUrl) else { return }
//      DispatchQueue.main.async {
////        if self.downloadedPreviewImageURL != nil { return }
////        self.downloadedPreviewImageURL = UIImage(data: data)
//      }
//    }
  }
}
