

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class FilmRepo {
    
    private static let context = DBMngr.disributedInstance.container.viewContext
    
    class func showFeatured(completion: @escaping (_ films:[Model]?, Error?)-> Void){
        let params = ["api_key":"64ec461f35b86ef59d2051bbde37b3cb"]
        Alamofire.request(ApiRepos.featuredFilmLink, method: .post, parameters: params, headers: nil)
            .responseJSON { (jsonRspnse) in
                let jsonRsult = jsonRspnse.result
                switch jsonRsult {
                case .success(let val):
                    let jsonRsult = JSON(val)
                    let JSONfilms = jsonRsult["results"]
                    var films = [Model]()
                    
                    for m in JSONfilms.arrayValue{
                        let film = Model()
                        film.load(JSON: m)
                        films.append(film)
                    }
                    
                    completion(films, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
                }
        }
    }
    
    class func showBestRated(completion: @escaping (_ films:[Model]?, Error?)-> Void){
        let params = ["api_key":"64ec461f35b86ef59d2051bbde37b3cb"]
        Alamofire.request(ApiRepos.upratedFilmLink, method: .post, parameters: params, headers: nil)
            .responseJSON { (rspnse) in
                let jsonRsult = rspnse.result
                
                switch jsonRsult {
                case .success(let value):
                    let jsonRsult = JSON(value)
                    let jsonFilms = jsonRsult["results"]
                    
                    var films = [Model]()
                    
                    for m in jsonFilms.arrayValue{
                        let film = Model()
                        film.load(JSON: m)
                        films.append(film)
                    }
                    
                    completion(films, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    class func showLoomingRelease(completion: @escaping (_ films:[Model]?, Error?)-> Void){
        let params = ["api_key":"64ec461f35b86ef59d2051bbde37b3cb"]
        Alamofire.request(ApiRepos.loomingReleaseFilmLink, method: .post, parameters: params, headers: nil)
            .responseJSON { (rspnse) in
                let jsonRsult = rspnse.result
                
                switch jsonRsult {
                case .success(let value):
                    let jsonRsult = JSON(value)
                    let jsonfilm = jsonRsult["results"]
                    
                    var films = [Model]()
                    
                    for m in jsonfilm.arrayValue{
                        let film = Model()
                        film.load(JSON: m)
                        films.append(film)
                    }
                    
                    completion(films, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
}
