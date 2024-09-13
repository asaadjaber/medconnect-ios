import UIKit

// MARK: - ScrollableViewController

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }()
    
    private var procedureCards: [ProcedureCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchProcedureCards()
        tableView.backgroundColor = .white
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(CarouselTableViewCell.self, forCellReuseIdentifier: CarouselTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchProcedureCards() {
        MockGraphQLService.shared.fetchProcedureCards { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self?.procedureCards = cards
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch procedure cards: \(error)")
                    // Handle error (e.g., show an alert to the user)
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // Example: Header, Carousel, Footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // Header cell
            let cell = UITableViewCell()
            cell.textLabel?.text = "Plastic Surgery Procedures"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            return cell
        case 1:
            // Carousel cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTableViewCell.identifier, for: indexPath) as? CarouselTableViewCell else {
                fatalError("Unable to dequeue CarouselTableViewCell")
            }
            cell.procedureCards = procedureCards
            return cell
        case 2:
            // Footer cell
            let cell = UITableViewCell()
            cell.textLabel?.text = "Please consult with a qualified medical professional before considering any procedure."
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.textColor = .gray
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 300
        case 2:
            return 80
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - CarouselLayout

class CarouselLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 20
        itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: 300)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        guard let rectAttributes = layoutAttributesForElements(in: targetRect) else { return proposedContentOffset }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.bounds.size.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
