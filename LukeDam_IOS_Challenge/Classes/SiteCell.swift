//
//  SiteCell.swift
//  LukeDam_IOS_Challenge
//
//  Created by Luke on 2020-05-09.
//  Copyright © 2020 Luke Dam. All rights reserved.
//


import UIKit

class SiteCell: UITableViewCell {

    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        primaryLabel.textAlignment = .left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 15)
        primaryLabel.backgroundColor = .clear
        primaryLabel.textColor = .black
        
        secondaryLabel.textAlignment = .left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 11)
        secondaryLabel.backgroundColor = .clear
        secondaryLabel.textColor = .blue
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
    }
    
    override func layoutSubviews() {
        primaryLabel.frame = CGRect(x: 5, y: 5, width: 360, height: 50)
        secondaryLabel.frame = CGRect(x: 5, y: 30, width: 360, height: 50)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}


