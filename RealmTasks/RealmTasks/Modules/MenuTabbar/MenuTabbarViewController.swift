//
//  ViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 20/04/2022.
//

import UIKit

enum TabbarTitle {
    case todo
    case weather
    case media
    case wisdom
    case setting
    
    static let all = [todo, weather, media, wisdom, setting]
    
    var text: String {
        get {
            switch self {
            case .todo:
                return "todo".language()
            case .weather:
                return "weather".language()
            case .media:
                return "media".language()
            case .wisdom:
                return "Mưu"
            case .setting:
                return "Setting".language()
            }
        }
    }
}

class MenuTabbarViewController: UITabBarController {
    var todoVC = TodoViewController()
    var weatherVC: WeatherViewController!
    var mediaVC: MediaViewController!
    var wisdomVC: WisdomViewController!
    
    var settingVC = SettingViewController()
    
    var tabbarType = TabbarTitle.todo
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.delegate = self
        setupTabbar()
    }
    
    private func setupTabbar() {
        todoVC = TodoViewController()
        weatherVC = R.storyboard.weather.weatherViewController()
        mediaVC = MediaViewController()
        wisdomVC = WisdomViewController()
        
        todoVC.tabBarItem.image = R.image.icons8Todo_list()
        //        dynastyVC.tabBarItem.selectedImage = R.image.dynasty()
        weatherVC.tabBarItem.image = R.image.icons8Wind_speed_3842()
        //        timelineVC.tabBarItem.selectedImage = R.image.timeline()
        mediaVC.tabBarItem.image = R.image.icons8Kodi()
        //        personVC.tabBarItem.selectedImage = R.image.king()
        
        wisdomVC.tabBarItem.image = R.image.icons8Ok()
        settingVC.tabItem.image = R.image.icons8Search()
        
        viewControllers = [todoVC, weatherVC, mediaVC, wisdomVC, settingVC]
        
        if let items = tabBar.items {
            for i in 0..<items.count {
                items[i].title = TabbarTitle.all[i].text
                items[i].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }
        
        //        for i in 0..<tabBar.items!.count {
        //            tabBar.items![i].title = TabbarTitle.all[i].text
        //            tabBar.items![i].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        //        }
    }
}

extension MenuTabbarViewController: UITabBarControllerDelegate {
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //        if viewController.isKind(of: DynastyViewController.self) {
        //            let vc =  R.storyboard.person.personDetailViewController()!
        //            vc.modalPresentationStyle = .overFullScreen
        //            self.present(vc, animated: true, completion: nil)
        //            return false
        //        }
        
        if viewController.isKind(of: TodoViewController.self) {
        }
        return true
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //This method will be called when user changes tab.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            tabBarController?.title = "\(index)"
        }
    }
    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            tabbarType = TabbarTitle.all[index]
            tabBarController.title = tabbarType.text //title for navigatio item
            viewController.title = tabbarType.text //title for tabbar button
            if viewController.isKind(of: WeatherViewController.self) || viewController.isKind(of: MediaViewController.self) {
                let image = R.image.icons8Menu_rounded()?.withRenderingMode(.alwaysTemplate)
                let menuMapButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(playTapped))
                menuMapButton.tintColor = UIColor.random
                menuMapButton.imageInsets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 0)
                navigationItem.rightBarButtonItem = menuMapButton
            } else {
                navigationItem.rightBarButtonItems?.removeAll()
            }
        }
    }
    
    @objc func playTapped() {
        switch tabbarType {
        case .weather:
            NotificationCenter.default.post(name: .changeMapType, object: nil)
        case .media:
            NotificationCenter.default.post(name: .openAllMedia, object: nil)
        default:
            break
        }
        
    }
}

