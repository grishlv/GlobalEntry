import UIKit

final class MainTableViewCell: UITableViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .white
        return imageView
    }()
    
    let filledHeartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    let textView: UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    var uniqueId: String?
    var favoriteId: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        layer.cornerRadius = 10
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        selectedBackgroundView.layer.cornerRadius = 10
        self.selectedBackgroundView = selectedBackgroundView
        
        contentView.addSubview(cellImageView)
        contentView.addSubview(heartImageView)
        contentView.addSubview(filledHeartImageView)
        contentView.addSubview(textView)
        
        cellImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(110)
        }
        
        heartImageView.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.top).offset(10)
            make.trailing.equalTo(cellImageView.snp.trailing).offset(-10)
            make.width.height.equalTo(25)
        }
        
        filledHeartImageView.snp.makeConstraints { make in
            make.edges.equalTo(heartImageView)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.leading.equalToSuperview().offset(13)
            make.trailing.lessThanOrEqualTo(cellImageView.snp.leading).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(feature: Feature, destination: String, requirement: String, image: UIImage? = nil) {
        
        let fullText = "\(destination)\nStaying: \(requirement)"
        let isFavorite = feature.isFavorite
        
        heartImageView.isHidden = isFavorite
        filledHeartImageView.isHidden = !isFavorite
        
        heartImageView.isUserInteractionEnabled = true
        filledHeartImageView.isUserInteractionEnabled = true
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1),
            .font: UIFont(name: "Inter-Bold", size: 18)!
        ]
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: fullText.count))
        
        let requirementAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1),
            .font: UIFont(name: "Inter-Bold", size: 14)!
        ]
        attributedString.addAttributes(requirementAttributes, range: (fullText as NSString).range(of: "Staying: \(requirement)"))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 5
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        textView.attributedText = attributedString
        applyCornerRadiusToImageView()
    }
    
    func updateImage(image: UIImage?) {
        cellImageView.image = image ?? UIImage(named: "placeholderImage")
        setNeedsLayout()
    }
    
    func applyCornerRadiusToImageView() {
        let path = UIBezierPath(roundedRect: cellImageView.bounds,
                                byRoundingCorners: [.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 10, height: 10))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        cellImageView.layer.mask = mask
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImageView.kf.cancelDownloadTask()
        self.cellImageView.image = UIImage(named: "placeholderImage")
    }
}
