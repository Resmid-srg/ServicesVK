//
//  ServiceCell.swift
//  ServicesVK
//
//  Created by Dima on 14.07.22.
//

import UIKit
import SDWebImage

protocol ServiceCellViewModel {
    var icon_url: String { get }
    var name: String { get }
    var description: String { get }
    var link: String { get }
}


class ServiceCell: UITableViewCell {
    
    static let reuseId = "ServiceCell"
    
    @IBOutlet var serviceDescriptionLabel: UILabel!
    @IBOutlet var serviceNameLabel: UILabel!
    @IBOutlet var serviceImageView: UIImageView!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func prepareForReuse() {
//        prepareForReuse()
//
//        serviceImageView.image = nil
//    }
    
    func set (viewModel: ServiceCellViewModel) {
        serviceNameLabel.text = viewModel.name
        serviceDescriptionLabel.text = viewModel.description
        
        serviceImageView.sd_setImage(with: URL(string: viewModel.icon_url), completed: nil)
        
    }
}
