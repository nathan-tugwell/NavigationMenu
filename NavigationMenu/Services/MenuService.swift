//
//  MenuService.swift
//  NavigationMenu
//
//  Created by Nathan Tugwell on 06/11/2018.
//  Copyright © 2018 nathantugwell. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MenuService {
    static let instance = MenuService()
    
    var menus = [Menu]()
    
    func findAllMenus(completion: @escaping CompletionHandler) {
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let navName = item["navigationName"].stringValue
                        let nav = item["navigation"].stringValue
                        let menu = Menu(me)
                        
                    }
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
