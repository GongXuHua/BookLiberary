//
//  DetailHeadViewController.swift
//  图书展示
//
//  Created by 陈楠 on 16/8/11.
//  Copyright © 2016年 chennan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
        //返回
    @IBAction func returnBack(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    var book:Book!
    var page = 0
    var reviews = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //给tableview的tableHeaderView赋值
        //tableView.tableHeaderView = NSBundle.mainBundle().loadNibNamed("DetailHeadView", owner: nil, options: nil)[0] as! UIView
        //DetailHeadView.showInTableHeadView(tableView,book: book)
        //行高自动估算
        
        if book != nil{
            DetailHeadView.showInVC(self)
            bookTitle.text = book.title
        }else{
            tableView.footerEndRefreshNoMoreData()
        }
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.footerAddMJRefresh {()->Void in
            NetManager.getCommentWithBookId(self.book.id, page: self.page, resultClosure: { (result, reviews) in
                if result{
                    let count = self.reviews.count
                    var indexPaths = [NSIndexPath]()
                    for (i,review) in reviews.enumerate(){
                        self.reviews.append(review)
                        indexPaths.append(NSIndexPath(forRow: count+i, inSection:0))
                    }
                    if indexPaths.isEmpty{
                        self.tableView.footerEndRefreshNoMoreData()
                    }else{
                        self.page += 1
                        //tableview
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                        self.tableView.footerEndRefresh()
                    }
                }else{
                    self.view.makeToast(" Net Error")
                    self.tableView.footerEndRefresh()
                }
            })
        }
        tableView.footerBeginRefresh()
    }
    
    
    func showImage(gesture:UIGestureRecognizer) {
        PhotoBrowser.showFromImageView(gesture.view as! UIImageView,URLStrings: self.URLStrings,index:index)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell", forIndexPath: indexPath) as! CommentTableViewCell
        cell.configure(reviews[indexPath.row])
        return cell
    }


}
