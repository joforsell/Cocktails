//
//  CocktailCell.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import UIKit

final class CocktailCell: UITableViewCell {
    static let identifier = "Cocktail"
    
    var imageLoader: ImageLoader?

    lazy var cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cocktailImageView)
        contentView.addSubview(name)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            cocktailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cocktailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cocktailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cocktailImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            name.leadingAnchor.constraint(equalTo: cocktailImageView.trailingAnchor, constant: padding),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        // Workaround for a bug(?) where UIView-Encapsulated-Layout-Height constraint set by UITableView was conflicting with the custom constraint.
        let heightConstraint = cocktailImageView.heightAnchor.constraint(equalTo: cocktailImageView.widthAnchor)
        heightConstraint.priority = UILayoutPriority(999)
        heightConstraint.isActive = true
    }
    
    func getImageWithUrl(_ urlString: String) async throws {
        let url = URL(string: urlString)!
        let image = try await imageLoader?.fetch(url)
        cocktailImageView.image = image
    }
}
