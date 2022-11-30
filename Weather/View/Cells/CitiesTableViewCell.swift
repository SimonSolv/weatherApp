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
            self.cityNameLabel.text = city!.name + " " + "\(city!.lon)" + " " + "\(city!.lat)"
            self.cityCountryLabel.text = city?.country
        }
    }
    
    lazy var cityNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var lonLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var latLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var cityCountryLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.font = .boldSystemFont(ofSize: 24)
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
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
        
        cityCountryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
            make.width.equalTo(20)
            make.trailing.equalTo(snp.trailing)
        }
    }

}
