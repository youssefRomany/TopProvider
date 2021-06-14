//
//  WebViewController.swift
//  Top12
//
//  Created by YoussefRomany on 5/11/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    var urlLink = ""
    var transitionId = ""
    let NETWORK = NetworkingHelper()
    var callApi = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NETWORK.deleget = self
        setupWebView()
        self.navigationItem.title = "الدفع"
        self.navigationController?.navigationBar.topItem?.title = ""

        // Do any additional setup after loading the view.
    }
    
    func setupWebView() {
        print("urlLink===\(urlLink)")
        let finalOne = urlLink.replacingOccurrences(of: "\"", with: "")
        if let url = URL(string: finalOne) {
            print(finalOne)
          webView.load(URLRequest(url: url))
        }
            webView.navigationDelegate = self
            webView.uiDelegate = self
    }

}



//MARK:- WK Navigation Delegate
extension WebViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.startAnimating()
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("DidTerminate==\(#function)")
        self.stopAnimating()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit==\(#function)")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish==\(#function)")
        self.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFail==\(#function)")
        callApi = false
//        ShowErrorMassge(massge: "فشل عملية الدفع".localized(), title: "Error".localized())
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//        //                    ShowTrueMassge(massge: "تم الدفع", title: "")
//                            self.navigationController?.popViewController(animated: true)
//
//                        }

    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        /*
         success or failed.
         PaymentError
         SuccessPayment
         mode=popup
         */
      let urli = navigationAction.request.url
        print(urli?.absoluteString ?? "m", "mmmmmmmmmmmmmmmm")
        if let urlString = urli?.absoluteString{
            if (urlString.containsIgnoringCase(find: "https://top12app.com/api/store_redirect_url?tap_id=")) && !(urlString.containsIgnoringCase(find: "mode=popup")) {
                if self.callApi{
                self.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//                    ShowTrueMassge(massge: "تم الدفع", title: "")
                        self.requestBillsApi()
                    }
                    self.callApi = false
                }
            
            }else if (urlString.containsIgnoringCase(find: "PaymentError")){
                
                
            }
        }
        
        if let url = navigationAction.request.url {
            print(url.absoluteString)
        }
        decisionHandler(.allow)
    }

    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
    }
    
    /// go to view controller and make it the root view
    ///
    /// - Parameter withId: the detination view controller id
    func pushToView(withId:String){
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        rootviewcontroller.rootViewController = storyboard.instantiateViewController(withIdentifier: withId)
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        UIView.transition(with: mainwindow, duration: 0.5, options: [.transitionFlipFromLeft], animations: nil, completion: nil)
    }
}

//MARK:- WK UI Delegate
extension WebViewController: WKUIDelegate{
//     func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("Finished navigating to url \(webView.url)");
//    }
}
extension String{
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}



//MARK:- Networking
extension WebViewController: NetworkingHelperDeleget {
    func onHelper(getData data: DataResponse<String>, fromApiName name: String, withIdentifier id: String) {
       handelBillsResponse(response: data)
    }
    
    func onHelper(getError error: String, fromApiName name: String, withIdentifier id: String) {
        ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
    }
    
    // MARK:- request apis from server
    func requestBillsApi() {
        NETWORK.connectWithHeaderTo(api: "https://top12app.com/api/getPaymentStatus?shop_id=\(getShopId())&transaction_id=\(transitionId)", withLoader: true, forController: self, methodType: .post)
    }
    // MARK:- handle response server
        func handelBillsResponse(response: DataResponse<String>){
            self.stopAnimating()
        switch response.response?.statusCode {
        case 200:
              do{
                let resp = try JSONDecoder().decode(CHeckPayment.self, from: response.data ?? Data())
 
                if resp.transaction_status == "CAPTURED"{
                    ShowTrueMassge(massge: "عملية الدفع تمت بنجاح".localized(), title: "Success".localized())

                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
    //                    ShowTrueMassge(massge: "تم الدفع", title: "")
                        self.pushToView(withId: "MyTabBAr")

                    }
                }else{
//                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
                    ShowErrorMassge(massge: "فشل عملية الدفع".localized(), title: "Error".localized())

                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
    //                    ShowTrueMassge(massge: "تم الدفع", title: "")
                        self.pushToView(withId: "MyTabBAr")

                    }
                }

            }catch let error{
                print(error,"mina")
                ShowErrorMassge(massge: "فشل عملية الدفع".localized(), title: "Error".localized())
            }
        default:
            ShowErrorMassge(massge: "فشل عملية الدفع".localized(), title: "Error".localized())
        }
    }

}
