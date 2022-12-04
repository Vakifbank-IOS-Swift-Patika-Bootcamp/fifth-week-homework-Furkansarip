//
//  IMDBViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import UIKit
import WebKit
import MaterialActivityIndicator

class IMDBViewController: UIViewController, WKNavigationDelegate {

    let indicator = MaterialActivityIndicatorView()
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.imdb.com/title/tt0903747/"
        if let url = URL(string: urlString) {
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
        }
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
                toolbarItems = [refresh]
                navigationController?.isToolbarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indicatorSetup()
        indicator.startAnimating()
    }
   
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
        }
    
    func indicatorSetup(){
        view.addSubview(indicator)
        indicator.color = .green
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    

}
