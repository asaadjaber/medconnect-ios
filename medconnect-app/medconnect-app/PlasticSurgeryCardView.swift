import UIKit

class PlasticSurgeryCardView: UIView {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "patient_image") // Replace with actual image
        return iv
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        return label
    }()
    
    private let proceduresLabel: UILabel = {
        let label = UILabel()
        label.text = "Liposuction • Rhinoplasty • Breast Implants"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(priceLabel)
        addSubview(proceduresLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        proceduresLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            priceLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            priceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            proceduresLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            proceduresLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            proceduresLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            proceduresLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with card: ProcedureCard) {
        priceLabel.text = "From $\(card.price)"
        imageView.image = UIImage(named: card.imageName)
        
        var procedures: String = ""
        for string in card.procedures {
            procedures.append(string)
            procedures.append(" • ")
        }
        _ = procedures.dropLast(3)
        proceduresLabel.text = procedures
    }
}
