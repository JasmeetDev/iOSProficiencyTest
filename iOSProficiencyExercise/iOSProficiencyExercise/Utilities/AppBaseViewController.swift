//
//  AppBaseViewController.swift
//  iOSProficiencyExercise
//
//  Created by Vaneet Modgill on 19/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//
import UIKit
import TDResult
import TDWebService
import MBProgressHUD


open class AppBaseViewController: UIViewController {
     
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Alert Method
    open func displayAlert(title:String, message:String, actionButtonTitle:String, controller:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionButtonTitle, style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    open func showWebServiceError(error:TDError, controller:UIViewController){
        var message = error.description ?? ""
        if error.error.localizedDescription == TDWebServiceError.networkNotReachable.localizedDescription {
            message = "Constant.NetworkError.networkNotReachable"
        }
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    
   // MARK:- Progress Method(s)
    open func showActivityLoader(_ progressView:UIView) {
        DispatchQueue.main.async {
            CustomLoader.sharedInstance.showActivityIndicator(uiView: progressView, title: "")
        }
    }
    
    open func hideActivityLoader(_ progressView:UIView) {
       DispatchQueue.main.async {
            CustomLoader.sharedInstance.hideActivityIndicator(onView: progressView)
        }
        
    }
}



class CustomLoader {
    
    static let sharedInstance = CustomLoader()
      var container: UIView = UIView()
    let imageView = UIView()


    func showActivityIndicator(uiView: UIView, title:String) {
        let loadingNotification = MBProgressHUD.showAdded(to: uiView, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading..."
        
        
    }
    
    func hideActivityIndicator(onView:UIView) {
        MBProgressHUD.hide(for: onView, animated: true)
        
    }
}
