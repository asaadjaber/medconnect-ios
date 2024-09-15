//
//  CarouselCell.swift
//  medconnect-app
//
//  Created by Asaad Jaber on 13/09/2024.
//

import UIKit

// MARK: - CarouselCell

class CarouselCell: UICollectionViewCell {
    static let identifier = "CarouselCell"
    
    let cardView: PlasticSurgeryCardView = {
        let view = PlasticSurgeryCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with card: ProcedureCard) {
        cardView.configure(with: card)
    }
}
