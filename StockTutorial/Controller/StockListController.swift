import UIKit

class StockListController: BaseViewController {
    let selfView = StockListView()
    

    override func configureUI() {
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.searchController = selfView.searchController
        selfView.searchController.delegate = self
        selfView.searchController.searchResultsUpdater = self
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
