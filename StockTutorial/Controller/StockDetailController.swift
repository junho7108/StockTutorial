import UIKit
import Pure

class StockDetailController: BaseViewController, FactoryModule {
    
    struct Dependency {
        let stock: Stock
        let viewModel: StockDetailViewModel
    }
    
    let stock: Stock
    let viewModel: StockDetailViewModel
    let selfView = StockDetailView()
    
    //MARK: - Lifecycle
    
    required init(dependency: Dependency, payload: ()) {
        self.stock = dependency.stock
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        enableScrollWhenKeyboardAppeared(scrollView: selfView.scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeListeners()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchTimeSeries(symbol: stock.symbol ?? "a", stock: stock)
        
        bind()
    }
    
    //MARK: - Configure
    
    override func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Detail"
        
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - bind
    
    func bind() {
        
        viewModel.loading
            .map { !$0 }
            .asDriver(onErrorJustReturn: false)
            .drive(selfView.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        viewModel.errorMessage
            .subscribe(onNext: { errorMessage in
                guard let message = errorMessage else { return }
                print("error: \(message.description)")
            })
            .disposed(by: disposeBag)
        
        viewModel.timeSeriesAdjusted
            .subscribe(onNext: { timeSeries in
                print(timeSeries?.monthInfos)
            })
            .disposed(by: disposeBag)
        
        viewModel.stockObservable
            .asDriver(onErrorJustReturn: Stock())
            .drive(onNext: { [unowned self] stock in
                self.selfView.topView.configureUI(stock: stock)
            })
            .disposed(by: disposeBag)
    }
}
