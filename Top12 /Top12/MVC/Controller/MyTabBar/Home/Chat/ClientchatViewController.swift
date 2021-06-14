//
//  ClientchatViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 3/23/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON
//import AnimatableReload
class ClientchatViewController: UIViewController {

    
    var selectedimage: UIImage?
    var msg = clientMsgsModel()
    var order_id = ""
    var user_id = ""
    var order = ClientOrders()
    fileprivate let cellId = "id123"
    let name = Notification.Name("didReceiveData")

    var massegeData : clientMsgsModel?
    var massages = [clientMsgsModel]()
    //=================
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var ChatTabel: UITableView!
    @IBOutlet weak var msgTxt: UITextView!
    @IBOutlet weak var sentBtn: UIButton!
    @IBOutlet weak var upload: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getAllMessages()
        self.navigationItem.title = "chat".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        UserDefaults.standard.set(order_id, forKey: "chat")
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: name, object: nil)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UserDefaults.standard.removeObject(forKey: "chat")
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func onDidReceiveData(_ notification:Notification) {
        
        print(notification.userInfo as? [String: String]!)
        getAllMessages()
        if let chat_ids = notification.userInfo as? [String: String]
        {
            let order_id = chat_ids["order_id"]
            let user_id = chat_ids["user_id"]
            print("💜\(user_id)")
            self.order_id = order_id!
            self.user_id = user_id!
            getAllMessages()
        }
        
    }
    
    
    func setupView(){
        
        if UserDefaults.standard.string(forKey: "client_id") != nil {
            user_id = UserDefaults.standard.string(forKey: "client_id")!
        }
        
        
        
        upload.setImage(#imageLiteral(resourceName: "picture"), for: .normal)
        sentBtn.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        locationBtn.setImage(#imageLiteral(resourceName: "locationclient"), for: .normal)
        if Language.currentLanguage() == "en"{
            back.image = #imageLiteral(resourceName: "back-1")
            
        }else{
            back.image = #imageLiteral(resourceName: "back-1")
            
        }
        msgTxt.layer.borderColor = UIColor.lightGray.cgColor
        msgTxt.layer.borderWidth = 0.5
        msgTxt.layer.cornerRadius = msgTxt.frame.height/2
        
        
        
        self.hideKeyboardWhenTappedAround()
        ChatTabel.rowHeight = UITableViewAutomaticDimension
        ChatTabel.estimatedRowHeight = 150
        ChatTabel.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    @IBAction func openLocation(_ sender: Any) {
        let Reg = Storyboard.Main.instantiate(GetLocationViewController.self)
        Reg.delegate = self
        self.navigationController?.pushViewController(Reg, animated: true)
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "chat")
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sent(_ sender: Any) {
        if msgTxt.text != "" {
            sentMsg(type:"1" , msg : msgTxt.text!)
        }
    }
    @IBAction func uploadPhoto(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = self.view
        alert.addAction(UIAlertAction(title: "Open camera".localized(), style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Open photo gallery".localized(), style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    func sentMsg(type:String , msg : String){
        
        if type == "1" {
            
            let parameters = ["user_id": getUserID(), "order_id": order_id, "type" : type ,"msg" : msg , "lang" : Language.currentLanguage()]  as [String: AnyObject]
            API.POST(url: CLIENT_SENT_MSG, parameters: parameters, headers: nil, completion: {
                ( succeeded: Bool,  result: [String: AnyObject]) in
                if succeeded {
                    self.stopAnimating()
                    print("🥥\(result)")
                    if result["status"] as? Int == 1{
                        if let data = result["data"] as? [String: Any] {
                            self.massages.append(clientMsgsModel().getObject(dicc: data))
                            self.ChatTabel.reloadData()
                            self.msgTxt.text = ""
                           DispatchQueue.main.async {
                                let indexPath = IndexPath(row: self.massages.count-1, section: 0)
                                self.ChatTabel.scrollToRow(at: indexPath, at: .bottom, animated: false)
                                self.view.layoutIfNeeded()
                                self.view.layoutSubviews()
                                self.ChatTabel.layoutIfNeeded()
                            }
                        }
                        
                    }else {
                        if let msg = JSON(result)["msg"].string {
                           ShowErrorMassge(massge: msg, title: "")
                        }
                    }
                    
                }else{
                    self.stopAnimating()
                    
                }
            })
        }else{
          self.startAnimating()
            let parameters = ["user_id": getUserID(), "order_id": order_id, "type" : type, "lang" : Language.currentLanguage()]  as [String: AnyObject]
            API.POSTImage(url: CLIENT_SENT_MSG, Images: [UIImagePNGRepresentation(self.selectedimage!)!], Keys: ["msg"], header: nil, parameters: parameters, completion: {
                ( succeeded: Bool,  result: [String: AnyObject]) in
                if succeeded {
                    self.stopAnimating()
                    print("🥥\(result)")
                    if result["status"] as? Int == 1{
                        if let data = result["data"] as? [String: Any] {
                            self.massages.append(clientMsgsModel().getObject(dicc: data))
                            self.ChatTabel.reloadData()
                            
                            self.msgTxt.text = ""
                            
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(row: self.massages.count-1, section: 0)
                                self.ChatTabel.scrollToRow(at: indexPath, at: .bottom, animated: false)
                                self.view.layoutIfNeeded()
                                self.view.layoutSubviews()
                                self.ChatTabel.layoutIfNeeded()
                            }
                        }
                        
                    }else {
                        if let msg = JSON(result)["msg"].string {
                            ShowErrorMassge(massge: msg, title: "")
                        }
                    }
                    
                }else{
                    self.stopAnimating()
                   
                }
            })
        }
    }
    
    func getAllMessages(){
       // self.startAnimating()
        self.massages.removeAll()
        API.GET(url: CLIENT_CHAT_MESSAGES + order_id + "&lang=" + Language.currentLanguage() + "&user_id=" + getUserID() , completion: {
            ( succeeded: Bool,  result: [String: AnyObject]) in
            if succeeded {
                //self.stopAnimating()
                print("🕌\(self.user_id)")
                print("🥥\(result)")
                if result["status"] as? Int == 1{
                    if let data = result["data"] as? [[String: Any]] {
                        self.massages.removeAll()
                        for msg in data {
                            self.massages.append(clientMsgsModel().getObject(dicc: msg))
                        }
                        self.ChatTabel.reloadData()
                        
                        DispatchQueue.main.async {
                            let indexPath = IndexPath(row: self.massages.count-1, section: 0)
                            if self.massages.count != 0{
                                
                                self.ChatTabel.scrollToRow(at: indexPath, at: .bottom, animated: false)
                                
                            }
                            self.view.layoutIfNeeded()
                            self.view.layoutSubviews()
                            self.ChatTabel.layoutIfNeeded()
                        }
                    }
                    
                    
                }else {
                    if let msg = JSON(result)["msg"].string {
                      ShowErrorMassge(massge: msg, title: "")
                        
                    }
                }
                
            }else{
               self.stopAnimating()
               
                
            }
        })
    }
    
    
}
extension ClientchatViewController : UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return massages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        cell.massegeData = self.massages[indexPath.row]
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if self.massages[indexPath.row].type == "text" {
            
            if (UIApplication.shared.canOpenURL(URL(string:"https://")!)) {
                UIApplication.shared.open(URL(string: self.massages[indexPath.row].msg)!, options: [:], completionHandler: nil)
            } else {
                print("Can't use comgooglemaps://")
            }
        }
    }
    
    
    
}
extension ClientchatViewController : UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    // MARK: - Imagepicker methods
    @objc func opengalary() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editingimage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            self.selectedimage = editingimage
        }else if let originalimage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.selectedimage = originalimage
        }
        self.sentMsg(type:"2" , msg : "")
        
           dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
    }
    
    
}
extension ClientchatViewController : sendDataBackDelegate{
    func finishPassing(location: String, lat: Double, lng: Double) {
        print("🍇\(lat)🍟\(lng)")
        sentMsg(type:"1" , msg : "http://maps.google.com/maps?saddr=" +  String(describing: lat) + "," + String(describing: lng))

    }
}


