import UIKit
import Combine

// MARK: - ProceduresViewController

class ProceduresViewController: UIViewController {
        
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }()
    
    private var procedureViewModel: ProceduresViewModel
    
    init(viewModel: ProceduresViewModel) {
        self.procedureViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        tableView.backgroundColor = .white
        
        setupTableView()
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
        
        procedureViewModel.$procedureCards
            .sink(receiveValue: applySnapshot)
            .store(in: &cancellables)
    }
    
    private func applySnapshot(_ procedureCards: [ProcedureCard]) {
        tableView.reloadData()
    }
}

extension ProceduresViewController: UITableViewDataSource, UITableViewDelegate {
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
            cell.procedureCards = procedureViewModel.procedureCards
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
