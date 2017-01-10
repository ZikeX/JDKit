//
//  WebViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/10.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: ScrollViewController {
    lazy var webView = WKWebView()
    
    override var scrollView: UIScrollView {
        return self.webView.scrollView
    }
    
    override func loadView() {
        self.view = self.webView
    }
}
