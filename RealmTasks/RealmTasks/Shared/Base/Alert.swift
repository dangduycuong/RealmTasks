//
//  Alert.swift
//  RealmTasks
//
//  Created by cuongdd on 22/04/2022.
//

import UIKit

enum AlertType {
    case notice
    case warning
    case error
    
    static var all = [notice,warning,error]
    var text: String {
        get {
            switch self {
            case .notice:
                return "Notice"
            case .warning:
                return "Warning"
            case .error:
                return "Error"
            }
        }
    }
}

class AlertService {
    func showAlert(type: AlertType, titleAlert: String?, message: String, titleLeftButton: String?, titleRightButton: String?, leftAction: @escaping () -> Void, rightAction: @escaping () -> Void) -> ShowAlertViewController {
        let vc = R.storyboard.alert.showAlertViewController()!
        vc.alertType = type
        vc.titleAlert = titleAlert
        vc.message = message
        vc.titleLeftButton = titleLeftButton
        vc.titleRightButton = titleRightButton
        vc.leftAction = leftAction
        vc.rightAction = rightAction
        return vc
    }
    
}
