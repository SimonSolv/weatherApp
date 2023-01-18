//
//  CitiesTableViewCell.swift
//  Weather
//
//  Created by Simon Pegg on 27.11.2022.
//

import UIKit
import SnapKit

class CitiesTableViewCell: UITableViewCell {
    static let identifier = "CitiesCell"
    
    var city: City? {
        didSet {
            self.cityNameLabel.text = city!.LocalizedName
            self.cityCountryLabel.text = city!.Country.LocalizedName
        }
    }
    
    lazy var cityNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.systemGray
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    
    lazy var cityCountryLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.systemGray4
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(cityNameLabel)
        addSubview(cityCountryLabel)
    }
    
    func setupConstraints() {
        cityNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(3)
            make.bottom.equalTo(snp.bottom).offset(-3)
            make.leading.equalTo(snp.leading).offset(10)
            make.trailing.equalTo(snp.trailing).offset(-50)
        }
        
        cityCountryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
        //    make.width.equalTo()
            make.trailing.equalTo(snp.trailing).offset(-5)
        }
    }

}
