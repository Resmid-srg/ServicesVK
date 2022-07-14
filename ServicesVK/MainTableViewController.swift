//
//  MainTableViewCOntroller.swift
//  ServicesVK
//
//  Created by Dima on 14.07.22.
//

import UIKit
import SwiftUI

class MainTableViewController: UITableViewController {

    var array = [Services]()
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: JSON
        
        let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        networkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let array):
                self?.array = array.body.services
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error:", error)
            }
        }
        
        //MARK: Design
        
        navigationItem.title = "Сервисы VK"
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        navigationItem.standardAppearance = .none
        navigationController?.navigationBar.isTranslucent = false
        
        //MARK: InitTable
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        let nib = UINib(nibName: "ServiceCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ServiceCell.reuseId)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.reuseId, for: indexPath) as! ServiceCell
        let service = array[indexPath.row]
        cell.set(viewModel: service)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = array[indexPath.row]
        let dir = service.link
        if let url  = URL(string: dir) {
            if UIApplication.shared.canOpenURL(url) {
                switch service.name {
                case "Все аптеки": UIApplication.shared.open(URL(string: "vseapteki://")!)
                case "My.Games": UIApplication.shared.open(URL(string: "mygamesapp://")!)
                case "Самокат": UIApplication.shared.open(URL(string: "samokat://")!)
                case "Ситидрайв": UIApplication.shared.open(URL(string: "youdriveapp://")!)
                case "Облако": UIApplication.shared.open(URL(string: "cloudmailru://")!)
                default: UIApplication.shared.open(url)
                }
                
            }
        }
    }
}
