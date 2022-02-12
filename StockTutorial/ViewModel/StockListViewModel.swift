import RxSwift

class StockListViewModel: BaseViewModel {
    
    let usecase: StockUseCase
    
    var stocks: BehaviorSubject<[Stock]> = .init(value: [])
    
    private var isEmpty: BehaviorSubject<Bool> = .init(value: false)
    
    var isEmptyObservable: Observable<Bool> {
        return isEmpty.asObservable()
    }
    
   //MARK: - Lifecycle
    
    init(usecase: StockUseCase) {
        self.usecase = usecase
     
        super.init()
        reduce()
    }
    
    //MARK: - Service
    
    func searchQueryChanged(query: String) {
        self.loading.onNext(true)
        
        usecase.fetchStocksPublisher(keywords: query)
            .subscribe { [unowned self] stockResult in
                self.loading.onNext(false)
                self.stocks.onNext(stockResult.items)
            } onError: { [unowned self] error in
                self.loading.onNext(false)
                self.errorMessage.onNext(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - Helpers
    
    private func reduce() {
        stocks.subscribe(onNext: { [unowned self] stocks in
            self.isEmpty.onNext(!stocks.isEmpty)
        })
        .disposed(by: disposeBag)
    }
}
