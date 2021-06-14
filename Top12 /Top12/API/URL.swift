//
//  URL.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//
import Foundation
import UIKit
import SwiftyJSON

typealias json = [String:AnyObject]
typealias DownloadCompleted = (JSON) -> ()
let BASE_URL = "https://top12app.com/api/"

let about_URL = "\(BASE_URL)about"
let Termis_Url = "\(BASE_URL)terms"
let Cities_Url = "\(BASE_URL)cities"
let AppInfo_Url =  "\(BASE_URL)app/info"
let Category_Url = "\(BASE_URL)categories"
let Complmint_Url = "\(BASE_URL)send/complaint"
let Nations_Url = "\(BASE_URL)nations"
let CheackCode_Url = "\(BASE_URL)check-code"
let ShopData_Url = "\(BASE_URL)my-shop"
let ShopDetils_Url = "\(BASE_URL)product/show"
let addOffer_Url = "\(BASE_URL)product/add-offer"
let DeleteOffer_Url = "\(BASE_URL)product/delete"
let Profile_Url = "\(BASE_URL)profile"
let Register_Url = "\(BASE_URL)register"
let Login_Url = "\(BASE_URL)login"
let ForgetPassword_Url = "\(BASE_URL)forgot/password"
let UpdatePassword_Url = "\(BASE_URL)update/password"
let CodeUpdatePass_Url = "\(BASE_URL)forgot/password/code"
let ProviderCurrentOrder_Url = "\(BASE_URL)order/provider/current"
let ProviderNewOrder_Url = "\(BASE_URL)provider/home"
let ChangeOrderStatus_Url = "\(BASE_URL)order/status"
let FinshedOrder_Url = "\(BASE_URL)order/finished"
let UpdateProfile_Url = "\(BASE_URL)update"
let Rate_Url = "\(BASE_URL)my-rate"
let AddProduct_Url = "\(BASE_URL)product/store"
let Notfications_URL = "\(BASE_URL)notify/show"
let Profile_URL = "\(BASE_URL)profile"
let UpdateShop_URL = "\(BASE_URL)update/shop"
let Wallet_URL = "\(BASE_URL)wallet"
let LogOut_URL = "\(BASE_URL)logout"
let TrackNewOrder_URL = "\(BASE_URL)track/provider/new"
let TrackProssingOrder_URL = "\(BASE_URL)track/loading"
let TrackPreviosOrder_URL = "\(BASE_URL)track/old"
let TrackChangeOrderStatus_Url = "\(BASE_URL)track/change/status"
let CategoryShop_Url = "\(BASE_URL)products/by-category"
let EditProduct_Url = "\(BASE_URL)product/update"
let MyDebt_Url = "\(BASE_URL)debt"
let Transfer_Url = "\(BASE_URL)transfer"
let Banks_Url = "\(BASE_URL)banks"
let Delgates_Url = "\(BASE_URL)book/all-delegates"
let SendDelgates_Url = "\(BASE_URL)book/send"
let Shopsearch_Url = "\(BASE_URL)product/search"
let Areas_Url = "\(BASE_URL)areas"
let ShowProduct_Url = "\(BASE_URL)order/provider"
let RacceptOrRefuse_URL = "\(BASE_URL)order/acceptOrRefuse"
let ListTime_URL = "\(BASE_URL)time-list"
let Delete_NotficationURL = "\(BASE_URL)notify/delete"
let CLIENT_ALL_MSGS = "\(BASE_URL)chat/getAll?user_id="
let CLIENT_CHAT_MESSAGES = "\(BASE_URL)chat/get?order_id="
let CLIENT_SENT_MSG = "\(BASE_URL)chat/send"
let MyCategory = "\(BASE_URL)my-category"
let UPDATE_LANG = "\(BASE_URL)changeLang"
let GET_HIEST_BID = "\(BASE_URL)getTomorrowPid"
let SET_HIEST_BID = "\(BASE_URL)setTomorrowPid"
let TOGGLE_ACTIVE = "\(BASE_URL)product/toggle_active"
let TOGGLE_OPEN = "\(BASE_URL)toggle_open"
let GET_BILLS = "\(BASE_URL)order/getProviderBills"
let TRANSFER = "\(BASE_URL)order/makeTransfer"
let SHOW_SHOP_DATA = "\(BASE_URL)show/shop"



