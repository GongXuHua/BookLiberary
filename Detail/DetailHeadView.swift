//
//  DetailHeadView.swift
//  图书展示
//
//  Created by 陈楠 on 16/8/11.
//  Copyright © 2016年 chennan. All rights reserved.
//

import UIKit

class DetailHeadView: UIView {

    weak var vc : DetailViewController?
    var tableView: UITableView!
    var book : Book!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageViewIcon: UIImageView!

    @IBOutlet weak var bookName: UILabel!

    @IBOutlet weak var scoreViewContainer: UIView!
    @IBOutlet weak var scoreNum: UILabel!

    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var bookSummary: UILabel!
    
    
    @IBAction func comment(sender: AnyObject) {
        vc?.navigationController?.pushViewController(UIStoryboard(name: "User",bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController"), animated: true)
    }

    @IBAction func collect(sender: AnyObject) {
    }
    
    
    static func showInVC(vc:DetailViewController) -> DetailHeadView {
        let headView = NSBundle.mainBundle().loadNibNamed("DetailHeadView", owner: nil, options: nil)[0] as! DetailHeadView
        headView.configureWith(vc.tableView, book: vc.book)
        headView.vc = vc
        headView.imageViewIcon.addGestureRecognizer(UITapGestureRecognizer(target: vc, action: "showImage:"))
        return headView
    }

    
    static func showInTableHeadView(tableview:UITableView,book:Book) -> DetailHeadView{
    
        let headView = NSBundle.mainBundle().loadNibNamed("DetailHeadView", owner: nil, options: nil)[0] as! DetailHeadView
        //配置headView
        headView.configureWith(tableview,book: book)
        return headView
    }
    //配置View
    func configureWith(tableView: UITableView,book:Book){
        
        self.tableView = tableView
        self.book = book
        
        imageViewIcon.sd_setImageWithURL(NSURL(string: book.image))
        bookName.text = book.title
        if let score = book.rating{
        
            ScoreView.showInView(scoreViewContainer, value: score.average)
            scoreNum.text = "\(score.numRaters)人评分"
        }else{
            ScoreView.showNoScore(scoreViewContainer)
        }
        //出版社
        var desc = ""
        for str in book.author{
            desc += (str+"/")
        }
        publisher.text = desc + "/" + book.publisher + "/" + book.pubdate
        bookSummary.text = book.summary
        //给tableview的headerView赋值为，我们自己定义的DetailHeadView
        self.tableView.tableHeaderView = self
        
    }
    //在xib中添加了一个viewContainer，它的高度随label行数变化，取它的的高，赋值给DetailHeadView
    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height = viewContainer.frame.size.height + 8 
        tableView.tableHeaderView = self
    }
    
}
