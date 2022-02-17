import UIKit
import Pure

class MainCoordinator: Coordinator, FactoryModule {
    
    struct Dependency {
        let stockListControllerFactory: () -> StockListController
        let stockDetailControllerFactory: (Stock) -> StockDetailController
        let selectDateControllerFactory: () -> SelectDateController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController: StockListController
    let stockDetailControllerFactory: (Stock) -> StockDetailController
    let selectDateControllerFactory: () -> SelectDateController
    
    required init(dependency: Dependency, payload: ()) {
        self.rootViewController = dependency.stockListControllerFactory()
        self.stockDetailControllerFactory = dependency.stockDetailControllerFactory
        self.selectDateControllerFactory = dependency.selectDateControllerFactory
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
    
    func stockCellTapped(item: Stock) {
        let vc = stockDetailControllerFactory(item)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dateInputTextFieldTapped() {
        let vc = SelectDateController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
