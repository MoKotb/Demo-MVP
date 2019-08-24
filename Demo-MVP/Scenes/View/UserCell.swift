import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var userEmailText: UILabel!
    @IBOutlet weak var userAddressText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension UserCell: UserCellView {
    func displayName(name: String) {
        userNameText.text = name
    }
    
    func displayEmail(email: String) {
        userEmailText.text = email
    }
    
    func displayAddress(address: String) {
        userAddressText.text = address
    }
}
