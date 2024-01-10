//
//  ArticleTableNewViewCell.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 09-01-24.
//

import UIKit
struct ArticleTableNewModel {
    let title: String
    let desc: String
    let imageURL: String?
    init(title: String, desc: String, imageURL: String) {
        self.title = title
        self.desc = desc
        self.imageURL = imageURL
    }
}
class ArticleTableNewViewCell: UITableViewCell {

    override func prepareForReuse() {
    }
    
    lazy var articleImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
    }()
    
    lazy var lblTitle: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var lblDescrip: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func configure(_ model: ArticleTableNewModel) {
        lblTitle.text = model.title
        lblDescrip.text = model.desc
        if let imageURL = model.imageURL {
            articleImageView.image = UIImage(named: "news")
        }
    }
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configLabels()
        setupUIUX()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configLabels() {
        lblTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        lblTitle.textColor = UIColor.black
        lblTitle.numberOfLines = 0
        
        lblDescrip.font = UIFont.systemFont(ofSize: 15.0)
        lblDescrip.textColor = UIColor.gray
        lblDescrip.numberOfLines = 0
     
    }
    
    func setupUIUX() {
        self.backgroundColor = .white
        addSubview(articleImageView)
        addSubview(lblTitle)
        addSubview(lblDescrip)
        
        articleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 22).isActive = true
        articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        //articleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        articleImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 22).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        lblDescrip.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        lblDescrip.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        lblDescrip.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true

        lblDescrip.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
  
    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

