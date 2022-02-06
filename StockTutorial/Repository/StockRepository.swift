import RxSwift

protocol StockRepository {
    func fetchStockPublisher(keywords: String, completion: @escaping ((Result<StockResult, Error>) -> Void))
}
