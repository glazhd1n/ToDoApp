import UIKit

class EditToDoRouter: EditToDoRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createEditToDoModule(todo: Todo) -> UIViewController {
        let view = EditToDoView()
        let interactor = EditToDoInteractor(todo: todo)
        let presenter = EditToDoPresenter()
        let router = EditToDoRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func closeEditToDoScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
