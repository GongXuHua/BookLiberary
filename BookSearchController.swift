//
//  BookSearchController.swift
//  图书展示
//
//  Created by 陈楠 on 16/7/31.
//  Copyright © 2016年 chennan. All rights reserved.
//

import UIKit

//添加继承协议UISearchResultUpdating
class BookSearchController: UIViewController, UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate{

    //MARK: - Property -
    var bookViewController:BookViewController!
    //声明全局变量UISearchController
    var searchController = UISearchController()
    //搜索框的提示字符串
    let searchPlaceHolder = "搜索图书"
    //搜索结果的文本
    var searchTitles = [String]()
    
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    
    //重写awakeFromNib方法
    override func awakeFromNib(){
        //用本Controller为输出结果Controller，创建UISearchController的对象
        searchController = UISearchController(searchResultsController: self)
        //数据更新，searchBar的搜索内容改变时，被SearchController自动通知searchResultsUpdater中的controller对象
        searchController.searchResultsUpdater = self
        //给searchBar添加提示文本字符串。
        searchController.searchBar.placeholder = searchPlaceHolder
        //设置取消按钮为白色
        searchController.searchBar.tintColor = UIColor.whiteColor()
        //打印searchView默认背景
        print(searchController.searchBar.subviews[0].subviews[0])
        //删掉SearchView的默认背景
        searchController.searchBar.subviews[0].subviews[0].removeFromSuperview()
        
    }
    
    //搜索框内容变化时会自动回调这个方法
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //修建searchBar中文本,去掉空格换行
        if let tag = searchController.searchBar.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) where !tag.isEmpty{
        NetManager.getBookTitles(tag, page: 0, resultClosure: { (titles) in
            self.searchTitles = titles
            self.tableView.reloadData()
        })
        }
    }
    
    //MARK - UITableVIew -
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = searchTitles[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTitles.count
    }
    //search后选择一行，刷新bookViewController中数据
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchController.active = false
        //bookViewController中关键字（tag），赋值为选中的这一行
        bookViewController.tag = searchTitles[indexPath.row]
        bookViewController.tableView.headerBeginRefresh()
    }
}
