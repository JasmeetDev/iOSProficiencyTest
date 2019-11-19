//
//  ListingTableCell.swift
//  iOSProficiencyExercise
//
//  Created by Vaneet Modgill on 19/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//

import UIKit
import Kingfisher
class ListingTableCell: UITableViewCell {
    var row:Row? {
        didSet {
            guard let row = row else {return}
            if row.title.isEmpty {
                contentTitleLabel.text = "N/A"
            } else {
                contentTitleLabel.text = row.title
            }
            
            if row.description.isEmpty {
                contentDescriptionLabel.text = "N/A"
            } else {
                contentDescriptionLabel.text = row.description
            }
            if let url = URL(string: row.imageHref) {
                contentImageView.kf.setImage(with: url)
            }
        }
    }
    let contentImageView:UIImageView = {
        let contentImage = UIImageView()
        contentImage.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        contentImage.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        contentImage.layer.cornerRadius = 35
        contentImage.backgroundColor = .lightGray
        contentImage.clipsToBounds = true
        return contentImage
    }()
    let contentTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentDescriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        self.contentView.addSubview(contentImageView)
        self.contentView.addSubview(contentTitleLabel)
        self.contentView.addSubview(contentDescriptionLabel)
        
        contentImageView.centerYAnchor.constraint(equalTo:marginGuide.centerYAnchor).isActive = true
        contentImageView.leadingAnchor.constraint(equalTo:marginGuide.leadingAnchor, constant:10).isActive = true
        contentImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        contentImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        
        
        contentTitleLabel.topAnchor.constraint(equalTo:marginGuide.topAnchor, constant: 10).isActive = true
        contentTitleLabel.leadingAnchor.constraint(equalTo:contentImageView.trailingAnchor, constant: 10).isActive = true
        contentTitleLabel.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor).isActive = true
        
        contentDescriptionLabel.bottomAnchor.constraint(equalTo:marginGuide.bottomAnchor).isActive = true
        contentDescriptionLabel.leadingAnchor.constraint(equalTo:contentTitleLabel.leadingAnchor, constant: 0).isActive = true
        contentDescriptionLabel.topAnchor.constraint(equalTo:contentTitleLabel.bottomAnchor).isActive = true
        contentDescriptionLabel.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
