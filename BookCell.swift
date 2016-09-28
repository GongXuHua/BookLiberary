//
//  BookCell.swift
//  图书展示
//
//  Created by 陈楠 on 16/7/24.
//  Copyright © 2016年 chennan. All rights reserved.
//

import UIKit
//此框架下载图片
import SDWebImage


class BookCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var rating: UIView!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var scoreRating: UIView!
    
    func configureWithBook(book: Book){
    
        bookImageView.sd_setImageWithURL(NSURL(string: book.image))
        
        //rating.text = ""
        if let rating = book.rating{
            ScoreView.showInView(scoreRating, value: rating.average)
        }else{
            ScoreView.showNoScore(scoreRating)
        }
        labelTitle.text = book.title
        var detail = ""
        for str in book.author{
        
            detail += (str + "/")
        }
        labelDetail.text = detail + book.publisher + "/" + book.pubdate
    }
}
