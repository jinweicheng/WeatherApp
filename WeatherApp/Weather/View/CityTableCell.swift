//
//  CityTableCell.swift
//  WeatherApp
//
//  Created by 程金伟 on 2022/7/26.
//

import UIKit

class CityTableCell: UITableViewCell {
    
    static let cellIdentifier = "CityTableCell_ID"
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 120, y: 0, width: 100, height: 50))
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
