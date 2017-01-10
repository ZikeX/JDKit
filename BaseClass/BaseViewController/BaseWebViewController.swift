//
//  BaseWebViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/10.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit
import WebKit
class BaseWebViewController: BaseViewController,AddChildScrollProtocol {
    lazy var webViewVC:WebViewController = WebViewController()
    var webView:WKWebView {
        return self.webViewVC.webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildScrollVC()
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        self.setNeedToRequest()
    }
    
    // MARK: -
    func createScrollVC(index: Int) -> WebViewController {
        return self.webViewVC
    }
    func getBottomView() -> UIView? {
        return nil
    }
    
    var hud:HUD?
    // MARK: -
    func webViewDidFinish() {
        
    }
}
extension BaseWebViewController:WKUIDelegate {
    
}
extension BaseWebViewController:WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        hud = HUD.showMessage("加载中")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hud?.hide()
        webViewDidFinish()
    }
}
