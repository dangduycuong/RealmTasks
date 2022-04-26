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
    
    static let all = [todo, weather, media]
    
    var text: String {
        get {
            switch self {
            case .todo:
                return "todo".language()
            case .weather:
                return "weather".language()
            case .media:
                return "media".language()
            }
        }
    }
}

class MenuTabbarViewController: UITabBarController {
    var todoVC: TodoViewController!
    var weatherVC: WeatherViewController!
    var mediaVC: MediaViewController!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.delegate = self
        setupTabbar()
    }
    
    private func setupTabbar() {
        todoVC = R.storyboard.todo.todoViewController()
        weatherVC = R.storyboard.weather.weatherViewController()
        mediaVC = R.storyboard.media.mediaViewController()
        
        todoVC.tabBarItem.image = R.image.icons8Todo_list()
        //        dynastyVC.tabBarItem.selectedImage = R.image.dynasty()
        weatherVC.tabBarItem.image = R.image.icons8Wind_speed_3842()
        //        timelineVC.tabBarItem.selectedImage = R.image.timeline()
        mediaVC.tabBarItem.image = R.image.icons8Kodi()
        //        personVC.tabBarItem.selectedImage = R.image.king()
        
        viewControllers = [todoVC, weatherVC, mediaVC]
        
        if let items = tabBar.items {
            for i in 0..<items.count {
                items[i].title = TabbarTitle.all[i].text
                items[i].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }
        print("cdd ", tabBarController == nil)
        
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
            tabBarController.title = TabbarTitle.all[index].text //title for navigatio item
            viewController.title = TabbarTitle.all[index].text //title for tabbar button
        }
        print("Selected view controller")
    }
    
    override func tabBar(_ tabBar: UITabBar, didBeginCustomizing items: [UITabBarItem]) {
        print("cdd didBeginCustomizing")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) {
        print("cdd willBeginCustomizing")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        print("cdd didEndCustomizing")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        print("cdd willEndCustomizing")
    }
}

