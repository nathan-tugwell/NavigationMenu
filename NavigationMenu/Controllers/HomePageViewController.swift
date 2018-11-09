//
//  HomePageViewController.swift
//  NavigationMenu
//
//  Created by Nathan Tugwell on 06/11/2018.
//  Copyright © 2018 nathantugwell. All rights reserved.
//

import UIKit
import Alamofire

typealias JSON = [String: Any]


struct NavJSON: Codable {
    let nav: Nav
}
struct Nav: Codable {
        let nav: [JSON]
}


class HomePageViewController: UIViewController {
    
    var navs = [Nav]()
    
    let API_URL = "https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/nav.json"

    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
            Alamofire.request(API_URL).responseJSON { response in
                let json = response.data
                
                do{
                    let decoder = JSONDecoder()
                    self.navs = try decoder.decode([Nav].self, from: json!)
                    
//                    for nav in self.navs {
//                        print(nav.navHome)
//                    }
                } catch let error {
                    print(error)
                }
            }
        }

}
