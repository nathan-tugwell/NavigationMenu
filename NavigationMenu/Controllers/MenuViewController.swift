//
//  MenuViewController.swift
//  NavigationMenu
//
//  Created by Nathan Tugwell on 06/11/2018.
//  Copyright © 2018 nathantugwell. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var navDict = [ [String: Any] ]()
    var allNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseURL(url: "https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/nav.json")
        
    }
    
    
    func parseURL(url: String) {
        let url = URL(string: url)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    
                }
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    
                    for (key, value) in parsedData {
                        //                            print("( \(key) --- \(value) " )
                        if (key == "nav") {
                            if let childrenArray:[ [String:Any] ] = value as? [ [String:Any] ] {
                                self.navDict = childrenArray
                                print(childrenArray.count)
                                for dict in childrenArray {
                                    for (key, value) in dict {
                                        if (key == "name") {
                                            self.allNames.append(value as! String)
                                            print(self.allNames)
                                    } else if (key == "children") {
                                        if let childrenDict:  [String:Any] = value as? [String: Any]  {
                                            if (key == "name") {
                                                print(childrenDict)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    }
            } catch let error as NSError {
                print(error)
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    
                }
            }
        }
    }.resume()
}

}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
        
        if cell == nil {
            cell = TableViewCell.init(style: .value1, reuseIdentifier: "cell")
        }
        
        let navItem = self.allNames[indexPath.row]
        cell?.nameLabel?.text = navItem
        
        cell?.accessoryView = UIImageView(image: UIImage(named: "icons8-chevron-right-50"))
        
        return cell!
    }
}



extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

