//
//  BookViewController.swift
//  图书展示
//
//  Created by 陈楠 on 16/7/23.
//  Copyright © 2016年 chennan. All rights reserved.
//

import UIKit
import AFNetworking
import BlocksKit
import FMDB
import Toast

class BookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - PROPERTY -
    var identifierBookCell = "BookCell"
    var page = 0 //当前的页码
    var tag = "Swift"
    var books = [Book]()
    
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //IOS 8自动估算行高
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        addMJHeaderFooter()
        tableView.headerBeginRefresh()
        
        //设置searchBar
        let searchController = storyboard?.instantiateViewControllerWithIdentifier("BookSearchController") as! BookSearchController
        
        searchController.bookViewController = self
        //把searhController中的searchBar添加到本controller中的searchView
        searchView.addSubview(searchController.searchController.searchBar)
    }
    
    //MARK: - UITableView -
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    //  重用单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCellWithIdentifier(identifierBookCell,forIndexPath:  indexPath) as! BookCell
        bookCell.configureWithBook(books[indexPath.row])
        return bookCell
    }
    // 选择列表中行
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //从storyBoard中添加controller
        let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailHeadViewController") as! DetailViewController
        detailViewController.book = books[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    //MARK: - MGRefresh -
    private func addMJHeaderFooter(){
        
        tableView.headerAddMJRefresh { () -> Void in
            self.tableView.footerResetNoMoreData()
            
            NetManager.getBooks(self.tag, page: 0, resultClosure: { (result, books) -> Void in
                self.tableView.headerEndRefresh()
                if result{
                
                    self.page = 1
                    self.books = books
                    self.tableView.reloadData()
                }else{
                    self.view.makeToast("请求失败")
                }
            })
        }
        tableView.footerAddMJRefresh { () -> Void in
            
            NetManager.getBooks(self.tag, page: self.page, resultClosure: { (reslut, books) -> Void in
                if reslut{
                    //NSIndexPath代表了一个 可以访问嵌套数组指定节点 的path
                    var indexPaths = [NSIndexPath]()
                    let count = self.books.count
                    for (i,book) in books.enumerate(){
                        self.books.append(book)
                        indexPaths.append(NSIndexPath(forRow: count + i, inSection: 0))
                    }
                    if indexPaths.isEmpty{
                        self.tableView.footerEndRefreshNoMoreData()
                    }else{
                        self.page += 1
                        self.tableView.footerEndRefresh()
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    }
                }else{
                    self.tableView.footerEndRefresh()
                    self.view.makeToast("请求数据失败")
                }
            })
        }
    }
    
}

