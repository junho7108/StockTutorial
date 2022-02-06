import RxSwift

protocol StockRepository {
    func fetchStockPublisher(keywords: String) -> Observable<StockResult>
}
