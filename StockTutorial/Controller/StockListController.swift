import UIKit
import Pure
import RxSwift
import RxCocoa

class StockListController: BaseViewController, FactoryModule {
    
    struct Dependency {
        let viewModel: StockListViewModel
    }
    
    let selfView = StockListView()
    
    let viewModel: StockListViewModel
    
    var coordinator: MainCoordinator?
    
    //MARK: - Lifecycle
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        enableScrollWhenKeyboardAppeared(scrollView: selfView.tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeListeners()
    }
    
    //MARK: - Configure
    override func configureUI() {
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.searchController = selfView.searchController
    }
    
    //MARK: - Bind
    
    func bind() {
        
        // Bind UI
        viewModel.loading
            .map { !$0 }
            .asDriver(onErrorJustReturn: false)
            .drive(selfView.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isEmptyObservable
            .asDriver(onErrorJustReturn: true)
            .drive(selfView.emptyView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.stocks
            .asDriver(onErrorJustReturn: [])
            .drive(selfView.tableView.rx.items(cellIdentifier: StockCell.identifier, cellType: StockCell.self)) { index, stock, cell in
                cell.configureUI(item: stock)
            }
        .disposed(by: disposeBag)
        
        // Bind Data
        selfView.searchController.searchBar.rx.text
            .debounce(.microseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.searchQueryChanged(query: text ?? "")
            })
            .disposed(by: disposeBag)
    
        viewModel.errorMessage
            .subscribe(onNext: { error in
                guard let error = error else { return }
                print("error: \(error)")
            })
            .disposed(by: disposeBag)
        
        selfView.tableView.rx.modelSelected(Stock.self)
            .subscribe(onNext: { [unowned self] stock in
                self.coordinator?.stockCellTapped(item: stock)
            })
            .disposed(by: disposeBag)
    
    }
}
