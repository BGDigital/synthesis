//
//  WebViewController.swift
//  synthesis
//
//  Created by XingfuQiu on 15/11/18.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate, UIAlertViewDelegate {

    var webUrl:String?
    var tt: String?
    @IBOutlet weak var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.web.delegate = self
        self.title = tt
        //远程网页
        guard let url = webUrl else {
            //这里是不是要返回上个界面
            UIAlertView(title: "异常", message: "请返回重试", delegate: self, cancelButtonTitle: "确定").show()
            return
        }
        
        self.pleaseWait()
        web.loadRequest(NSURLRequest(URL: NSURL(string:URL_DETAILS+url)!))
        // Do any additional setup after loading the view.
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.clearAllNotice()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.clearAllNotice()
    }

    
    //显示Web 的 title
    func webViewDidFinishLoad(webView: UIWebView)
    {
        self.clearAllNotice()
        
//        self.title =  self.web.stringByEvaluatingJavaScriptFromString("document.title")
        
        
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?)
    {
        self.clearAllNotice()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
