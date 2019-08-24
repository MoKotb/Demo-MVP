import Foundation
import Alamofire
import AlamofireObjectMapper

class UsersInteractor{
    
    func getAllUsers(complitionHandler: @escaping ([User]?,Error?)->()){
        Alamofire.request("https://jsonplaceholder.typicode.com/users").responseArray { (response:DataResponse<[User]>) in
            let result = response.result
            switch result{
                case .success(let users):
                    complitionHandler(users,nil)
                    break
                case .failure(let error):
                    complitionHandler(nil,error)
                    break
            }
        }
    }
}
