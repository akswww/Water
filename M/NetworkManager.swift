import UIKit


class NetWorkManager {
    private func handleHTTPMethod<E: Encodable>(method: NetworkConstants.HTTPMethod,
                                                path: NetworkConstants.ApiPath,
                                                parameters: E?) -> URLRequest {
        
        let baseURL = NetworkConstants.ApiAdress
        let url = URL(string: baseURL + path.rawValue)!
        var urlReguest = URLRequest(url:url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        let httpType = NetworkConstants.ContentType.json.rawValue
        urlReguest.allHTTPHeaderFields = [NetworkConstants.HttpHeaderField.contentType.rawValue :httpType]
        
        urlReguest.httpMethod = method.rawValue
        
        let dict1 = try? parameters?.asDictionary()
        switch method {
        case .get:
            let parameters = dict1 as? [String : String]
            urlReguest.url = requestWithURL(urlString:urlReguest.url?.absoluteString ?? "", parameters: parameters ?? [:])
        default:
            urlReguest.httpBody = try? JSONSerialization.data(withJSONObject: dict1 ?? [:], options: .prettyPrinted)
        }
        return urlReguest
    }
    
    public func requestData<E,  D>(method:  NetworkConstants.HTTPMethod,
                                   path: NetworkConstants.ApiPath,
                                   parameters: E) async throws -> D where E: Encodable, D: Decodable {
        let urlRequest = handleHTTPMethod(method: method, path: path, parameters: parameters)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let response = (response as? HTTPURLResponse) else {
                throw NetworkConstants.RequestError.invalidResponse
            }
            
            let statusCode = response.statusCode
            guard (200 ... 299).contains(statusCode) else {
                switch statusCode {
                case 400:
                    throw NetworkConstants.RequestError.badRequest
                case 401:
                    throw NetworkConstants.RequestError.authorizationError
                case 404:
                    throw  NetworkConstants.RequestError.notFound
                case 500:
                    throw NetworkConstants.RequestError.internalError
                case 502:
                    throw NetworkConstants.RequestError.badGateway
                case 503:
                    throw NetworkConstants.RequestError.serverUnavailable
                default:
                    throw NetworkConstants.RequestError.invalidResponse
                }
            }
            
            
            
            do{
                let result = try JSONDecoder().decode(D.self, from: data)
                
                //                            printNeworkProgress(urlRequest, parameters, result)
                
                return result
            } catch {
                
                throw NetworkConstants.RequestError.jsonDecodeFailed(error as! DecodingError)
            }
            
            
            
            
                
            } catch {
                print(error.localizedDescription)
                throw NetworkConstants.RequestError.unknownError(error)
            }
        }
    }

private func requestWithURL(urlString: String, parameters: [String : String]?) -> URL? {
    guard var urlComponents = URLComponents(string: urlString) else { return nil }
    urlComponents.queryItems = []
    parameters?.forEach { (key, value) in
        urlComponents.queryItems?.append(URLQueryItem(name: key,value:value))
        
    }
    return urlComponents.url
}

extension Encodable {
    func asDictionary() throws -> [String:Any] {
        let data = try JSONEncoder().encode(self)
        guard let dicationary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else {
            throw NSError()
        }
        return dicationary
    }
}






