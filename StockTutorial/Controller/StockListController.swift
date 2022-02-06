import UIKit
import Pure

class StockListController: BaseViewController, FactoryModule {
    
    struct Dependency {
        let viewModel: StockListViewModel
        
    }
    
    let selfView = StockListView()
    let viewModel: StockListViewModel
    
    required init(dependency: Dependency, payload: ()) {
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        viewModel.fetchStocks()
    }
    
    override func configureUI() {
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.searchController = selfView.searchController
        selfView.searchController.delegate = self
        selfView.searchController.searchResultsUpdater = self
    }
    
    func bind() {
        
        viewModel.loading.subscribe(onNext: { isLoading in
            print("loading: \(isLoading)")
        }).disposed(by: disposeBag)
        
        viewModel.errorMessage.subscribe(onNext: { error in
            guard let error = error else { return }
            print("error: \(error)")
        }).disposed(by: disposeBag)
        
        viewModel.stocks
            .subscribe(onNext: { stocks in
                print("stocks: \(stocks)")
            }).disposed(by: disposeBag)
    }
}

//MARK: - UISearchControllerDelegate

extension StockListController: UISearchControllerDelegate {
    
}

//MARK: - UISearchResultsUpdating

extension StockListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}