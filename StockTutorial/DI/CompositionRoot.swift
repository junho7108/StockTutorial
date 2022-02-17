struct AppDependency {
    let mainCoordinator: MainCoordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        
        let stockRepositry: StockRepository = StockRepositoryImpl()
        
        let stockListControllerFactory: () -> StockListController = {
            let usecase = StockUseCase(stockRepository: stockRepositry)
            let viewModel = StockListViewModel(usecase: usecase)
            return .init(dependency: .init(viewModel: viewModel))
        }
        
        let stockDetailControllerFactory: (Stock) -> StockDetailController = { stock in
            let usecase = StockDetailUseCase(stockRepository: stockRepositry)
            let viewModel = StockDetailViewModel(usecase: usecase)
            return .init(dependency: .init(stock: stock, viewModel: viewModel))
        }
        
        let selectDateControllerFactory: () -> SelectDateController = {
            return .init()
        }
        
        let mainCoordinator: MainCoordinator = .init(dependency: .init(stockListControllerFactory: stockListControllerFactory,
                                                                       stockDetailControllerFactory: stockDetailControllerFactory,
                                                                       selectDateControllerFactory: selectDateControllerFactory))
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
