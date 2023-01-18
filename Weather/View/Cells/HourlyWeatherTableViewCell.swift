//
//  HourlyWeatherTableViewCell.swift
//  Weather
//
//  Created by Simon Pegg on 04.12.2022.
//

import UIKit
import SnapKit

class HourlyWeatherTableViewCell: UITableViewCell {
    
    static let  identifier = "HourlyWeatherTableViewCell"
    
    var delegate: GeneralViewController?
    
    var cellsSource: [HourWeather]? {
        didSet {
            self.weatherCollectionView.reloadData()
        }
    }
    
    lazy var detailButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("Подробнее на 24 часа", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(showDetailed), for: .touchUpInside)
        return btn
    }()
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        view.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier )
        view.dataSource = self
        view.delegate = self
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(weatherCollectionView)
        contentView.addSubview(detailButton)
        weatherCollectionView.showsHorizontalScrollIndicator = false
        weatherCollectionView.snp.makeConstraints {(make) in
            make.top.equalTo(detailButton.snp.bottom).offset(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.leading.equalTo(contentView.snp.leading).offset(2)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(100)
        }
        
        detailButton.snp.makeConstraints {(make) in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.height.equalTo(25)
        }
    }
    
    @objc func showDetailed() {
        delegate!.showDetailedViewController()
    }

}

extension HourlyWeatherTableViewCell: UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsSource?.count ?? 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as! HourlyWeatherCollectionViewCell
        cell.hourlyWeather = cellsSource?[indexPath.row]
        return cell
    }
}

extension HourlyWeatherTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 42, height: 84)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

}
