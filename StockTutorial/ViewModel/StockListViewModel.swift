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
    }
    
    func searchQueryChanged(query: String) {
        self.loading.onNext(true)
        
        usecase.fetchStocksPublisher(keywords: query)
            .subscribe { [unowned self] stockResult in
                stockResult.items.count > 0 ? isEmpty.onNext(true) : isEmpty.onNext(false)
                self.loading.onNext(false)
                self.stocks.onNext(stockResult.items)
            } onError: { [unowned self] error in
                self.loading.onNext(false)
                self.errorMessage.onNext(error.localizedDescription)
            }.disposed(by: disposeBag)

    }
}
