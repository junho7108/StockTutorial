import RxSwift

class StockDetailViewModel: BaseViewModel {
    
    let usecase: StockDetailUseCase
    
    var timeSeriesAdjusted: BehaviorSubject<TimeSeriesMonthlyAdjusted?> = .init(value: nil)
    
    private var monthInfos: BehaviorSubject<[MonthInfo]> = .init(value: [])
    
    var monthInfoObservable: Observable<[MonthInfo]> {
        return monthInfos.asObserver()
    }
    
    init(usecase: StockDetailUseCase) {
        self.usecase = usecase
        
        super.init()
        bind()
    }
    
    func fetchTimeSeries(symbol: String) {
        loading.onNext(true)
        
        usecase.fetchTimeSeriesPublisher(keywords: symbol)
            .subscribe { [unowned self] timeSeries in
                self.loading.onNext(false)
                self.timeSeriesAdjusted.onNext(timeSeries)
            } onError: { [unowned self] error in
                self.errorMessage.onNext(error.localizedDescription)
                self.loading.onNext(false)
            }
            .disposed(by: disposeBag)
    }
    
    func bind() {
        timeSeriesAdjusted
            .subscribe(onNext: { [unowned self] timeSeries in
                guard let timeSeries = timeSeries else { return }
                
                self.monthInfos.onNext(timeSeries.generateMonthInfos())
            })
            .disposed(by: disposeBag)
    }
}
