//
//  TaskCell.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/01/26.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    static let identifier = "TaskCell"
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var badgeContainerView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    private func setupStyle() {
        badgeContainerView.layer.cornerRadius = 6
        badgeContainerView.clipsToBounds = true
        badgeLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    
    func configure(with task: UserTask) {
        titleLabel.text = task.title
        badgeLabel.text = task.status?.name
        
        switch task.status?.code {
        case "DONE":
            statusImageView.image = UIImage(systemName: "circle.fill")
            statusImageView.tintColor = .systemGreen
            
            styleBadge(color: .systemGreen.withAlphaComponent(0.2), textColor: .systemGreen)
            
        case "PROG":
            statusImageView.image = UIImage(systemName: "circle.righthalf.filled.inverse")
            statusImageView.tintColor = .systemBlue
            
            styleBadge(color: .systemBlue.withAlphaComponent(0.2), textColor: .systemBlue)
            
        default:
            statusImageView.image = UIImage(systemName: "circle")
            statusImageView.tintColor = .systemGray
            
            styleBadge(color: .systemGray5, textColor: .systemGray)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            let transform: CGAffineTransform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            let alpha: CGFloat = isHighlighted ? 0.7 : 1.0
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.transform = transform
                self.alpha = alpha
            }, completion: nil)
        }
    }
    
    private func styleBadge(color: UIColor, textColor: UIColor) {
        badgeContainerView.backgroundColor = color
        badgeLabel.textColor = textColor
    }
}
