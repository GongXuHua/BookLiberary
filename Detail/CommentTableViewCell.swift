//
//  CommentTableViewCell.swift
//  图书展示
//
//  Created by 陈楠 on 16/8/17.
//  Copyright © 2016年 chennan. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!

    @IBOutlet weak var commentTitle: UILabel!
    
    @IBOutlet weak var commentName: UILabel!
    
    @IBOutlet weak var RatingView: UIView!
    @IBOutlet weak var commentContent: UILabel!
    
    @IBOutlet weak var scoreNum: UILabel!
    @IBOutlet weak var scoreDate: UILabel!
    
    
    func configure(review: Comment){
        headImage.sd_setImageWithURL(NSURL(string: review.cName.avatar))
        commentTitle.text = review.title
        commentName.text = review.cName.name
        if let rating = review.rating {
            ScoreView.showInView(RatingView, value: rating.average)
            scoreNum.text = Int(rating.numRaters).description
        }else{
            ScoreView.showNoScore(RatingView)
        }
        commentContent.text = review.summary
        scoreDate.text = review.update
    }

}
