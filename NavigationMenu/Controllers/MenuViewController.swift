//
//  MenuViewController.swift
//  NavigationMenu
//
//  Created by Nathan Tugwell on 06/11/2018.
//  Copyright © 2018 nathantugwell. All rights reserved.
//

import UIKit

struct Menu: Decodable {
    var nav = [Menus]()
    
}

struct Menus: Decodable {
    var name: String
}


class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var menu: Menu?
    
    let API_URL = "https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/nav.json"

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: API_URL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                self.menu = try decoder.decode(Menu.self, from: data)
//                print(self.menu?.nav as Any)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print("failed", error)
            }
            }.resume()
        
    }

}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu?.nav.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        }
        let navItem = self.menu?.nav[indexPath.row]
        cell?.textLabel?.text = navItem?.name
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
