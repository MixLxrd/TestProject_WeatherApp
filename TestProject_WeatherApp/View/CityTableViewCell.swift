//
//  CityTableViewCell.swift
//  TestProject_WeatherApp
//
//  Created by Mike on 01.09.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    var nameCityTextLabel = UILabel()
    var temperatureTextLabel = UILabel()
    var conditionTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameCityTextLabel.toAutoLayout()
        temperatureTextLabel.toAutoLayout()
        conditionTextLabel.toAutoLayout()
        
        nameCityTextLabel.font = UIFont.systemFont(ofSize: 25)
        temperatureTextLabel.font = UIFont.systemFont(ofSize: 25)
        conditionTextLabel.textColor = .lightGray
        
        addSubview(conditionTextLabel)
        addSubview(nameCityTextLabel)
        addSubview(temperatureTextLabel)
        
        let constraints = [
            
            nameCityTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameCityTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            
            conditionTextLabel.topAnchor.constraint(equalTo: nameCityTextLabel.bottomAnchor, constant: 4),
            conditionTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            conditionTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            temperatureTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            temperatureTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
