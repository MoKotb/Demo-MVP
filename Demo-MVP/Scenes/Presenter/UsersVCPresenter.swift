import Foundation

protocol UsersView: class {
    func showIndicator()
    func hideIndicator()
    func fetchingUserData()
    func showError(error:String)
}

protocol UserCellView {
    func displayName(name:String)
    func displayEmail(email:String)
    func displayAddress(address:String)
}

class UsersVCPresenter {
    
    private let interactor = UsersInteractor()
    private weak var view:UsersView?
    private var users = [User]()
    
    init(view:UsersView) {
        self.view = view
    }
    
    func viewDidLoad() {
        getUsers()
    }
    
    func getUsers(){
        users = []
        view?.showIndicator()
        interactor.getAllUsers { [weak self] (users, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            }else{
                guard let users = users else { return }
                self.users = users
                self.view?.fetchingUserData()
            }
        }
    }
    
    func getUserCount() -> Int{
        return users.count
    }
    
    func configureCell(cell:UserCellView,index:Int){
        let user = users[index]
        cell.displayName(name: user._name)
        cell.displayEmail(email: user._email)
        cell.displayAddress(address: "\(user._address._street) \(user._address._suite)")
    }
}
