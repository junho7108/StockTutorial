import RxSwift

protocol StockRepository {
    func fetchStockPublisher(keywords: String) -> Observable<StockResult>
    func fetchTimeSeriesPublisher(keywords: String) -> Observable<TimeSeriesMonthlyAdjusted>
}

