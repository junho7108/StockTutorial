import RxSwift

class StockListViewModel {
    var loading: BehaviorSubject<Bool> = .init(value: false)
    var errorMessage: BehaviorSubject<String?> = .init(value: nil)
    var stocks: BehaviorSubject<[Stock]> = .init(value: [])
    
    private var isEmpty: BehaviorSubject<Bool> = .init(value: false)
    var isEmptyObservable: Observable<Bool> {
        return isEmpty.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    let usecase: StockUseCase
    
    init(usecase: StockUseCase) {
        self.usecase = usecase
        reduce()
    }
    
    func searchQueryChanged(query: String) {
        self.loading.onNext(true)
        
        usecase.fetchStocksPublisher(keywords: query)
            .subscribe { [unowned self] stockResult in
                self.loading.onNext(false)
                self.stocks.onNext(stockResult.items)
            } onError: { [unowned self] error in
                self.loading.onNext(false)
                self.stocks.onNext([])
                self.errorMessage.onNext(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func reduce() {
        stocks.subscribe(onNext: { [unowned self] stocks in
            self.isEmpty.onNext(!stocks.isEmpty)
        })
        .disposed(by: disposeBag)
    }
}
