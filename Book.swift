//
//  Book.swift
//  图书展示
//
//  Created by 陈楠 on 16/7/24.
//  Copyright © 2016年 chennan. All rights reserved.
//

import UIKit

struct Book {
    
     let KeyId = "id"
     let KeyIsbn10 = "isbn10"
     let KeyIsbn13 = "isbn13"
     let KeyTitle = "title"
     let KeyOrigin_title = "origin_title"
     let KeyAlt_title = "alt_title"
     let KeySubtitle = "subtitle"
     let KeyUrl = "url"
     let KeyAlt = "alt"
     let KeyImage = "image"
     let KeyImages = "images"
     let KeyAuthor = "author"
     let KeyTranslator = "translator"
     let KeyPublisher = "publisher"
     let KeyPubdate = "pubdate"
     let KeyRating = "rating"
     let KeyTags = "tags"
     let KeyBinding = "binding"
     let KeyPrice = "price"
     let KeySeries = "series"
     let KeyPages = "pages"
     let KeyAuthor_info = "author_info"
     let KeySummary = "summary"
     let KeyCatalog = "catalog"
     let KeyEbook_url = "ebook_url"
     let KeyEbook_price = "ebook_price"

    var id = ""
    var isbn10 = ""
    var isbn13 = ""
    var title = ""
    var origin_title = ""
    var alt_title = ""
    var subtitle = ""
    var url = ""
    var alt = ""
    var image = ""
    var images = [String:String]()  //key: small, large,medium
    var author = [String]()
    var translator = [String]()
    var publisher = ""
    var pubdate = ""
    var rating:Score?
    var tags = [[String:NSObject]]()
    var binding = ""
    var price = ""
    var series = [String:String]()
    var pages = ""
    var author_info = ""
    var summary = ""
    var catalog = ""
    var ebook_url = ""
    var ebook_price = ""
    
    init(dict:[String : NSObject]){
    
        id = dict[KeyId] as? String ?? ""
        isbn10 = dict[KeyIsbn10] as? String ?? ""
        isbn13 = dict[KeyIsbn13] as? String ?? ""
        title = dict[KeyTitle] as? String ?? ""
        origin_title = dict[KeyOrigin_title] as? String ?? ""
        alt_title = dict[KeyAlt_title] as? String ?? ""
        subtitle = dict[KeySubtitle] as? String ?? ""
        url = dict[KeyUrl] as? String ?? ""
        alt = dict[KeyAlt] as? String ?? ""
        image = dict[KeyImage] as? String ?? ""
        images = dict[KeyImages] as? [String:String] ?? [:]
        author = dict[KeyAuthor] as? [String] ?? []
        translator = dict[KeyTranslator] as? [String] ?? []
        publisher = dict[KeyPublisher] as? String ?? ""
        pubdate = dict[KeyPubdate] as? String ?? ""
        if let ratingDict = dict[KeyRating] as? [String:NSObject]{
            rating = Score(dict: ratingDict)
        }
        tags = dict[KeyTags] as? [[String:NSObject]] ?? []
        binding = dict[KeyBinding] as? String ?? ""
        price = dict[KeyPrice] as? String ?? ""
        series = dict[KeySeries] as? [String:String] ?? [:]
        pages = dict[KeyPages] as? String ?? ""
        author_info = dict[KeyAuthor_info] as? String ?? ""
        summary = dict[KeySummary] as? String ?? ""
        catalog = dict[KeyCatalog] as? String ?? ""
        ebook_url = dict[KeyEbook_url] as? String ?? ""
        ebook_price = dict[KeyEbook_price] as? String ?? ""
        
    }
    
}
