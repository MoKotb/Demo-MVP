import UIKit

class UsersVC: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var presenter:UsersVCPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UsersVCPresenter(view: self)
        setupView()
    }
    
    private func setupView(){
        presenter.viewDidLoad()
        title = "Users"
        indicator.isHidden = true
        setupTableView()
    }
    
    private func setupTableView(){
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
}

extension UsersVC: UsersView{
    func showIndicator() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func hideIndicator() {
        indicator.isHidden = true
        indicator.stopAnimating()
    }
    
    func fetchingUserData() {
        usersTableView.reloadData()
    }
    
    func showError(error: String) {
        print(error)
    }
}

extension UsersVC: UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getUserCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell {
            presenter.configureCell(cell: cell, index: indexPath.row)
            return cell
        }else{
            return UserCell()
        }
    }
}
