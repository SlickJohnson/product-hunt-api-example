//
//  Comment.swift
//  ProductHuntExample
//
//  Created by Willie Johnson on 7/30/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

struct Comment: Decodable {
  let id: Int
  let body: String
}

struct CommentApiResponse: Decodable {
  let comments: [Comment]?
}
