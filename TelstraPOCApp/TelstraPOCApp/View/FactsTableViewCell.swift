//
//  FactsTableViewCell.swift
//  TelstraPOCApp
//
//  Created by Nikhil Wagh on 04/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.titleColor
        nameLabel.font = UIFont(name: Constants.customFontBold, size: CGFloat(Constants.titleFontSize))
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    private let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont(name: Constants.customFont, size: CGFloat(Constants.descFontSize))
        descriptionLabel.textAlignment = .left
        descriptionLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let nameImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = UIColor.themeColor
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(nameImageView)
        
        nameImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, enableInsets: false)
        nameImageView.anchorSize(width: CGFloat(Constants.imageViewWidth), height: CGFloat(Constants.imageViewHeight))
        
        nameLabel.anchor(top: topAnchor, left: nameImageView.rightAnchor, bottom: nil, right: rightAnchor, enableInsets: false)
        nameImageView.anchorSize(width: frame.size.width, height: CGFloat(Constants.zero))
        
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(Constants.heightConstant)).isActive = true
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: nameImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, enableInsets: false)
        descriptionLabel.anchorSize(width: frame.size.width, height: CGFloat(Constants.zero))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    /// This method is to configure cell
    /// - Parameters:
    ///   - viewModel: This parameter is to access factsArray from ViewModel
    ///   - indexPath: IndexPath of tableView to display perticular row info
    func configureCell(viewModel: FactsViewModel, indexPath: IndexPath) {
        let fact = viewModel.factsArray[indexPath.row]
        nameImageView.imageFromServerURL(fact.imageURL ?? "", placeHolder: #imageLiteral(resourceName: "placeholder"))
        nameLabel.text = fact.title
        descriptionLabel.text = fact.description
    }
}
