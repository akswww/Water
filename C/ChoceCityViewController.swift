//
//  ChoceCityViewController.swift
//  Api
//
//  Created by imac-1681 on 2023/8/14.
//

import UIKit

class ChoceCityViewController: UIViewController {
    
    @IBOutlet weak var imageIge: UIImageView!
    @IBOutlet weak var TodayLbl: UILabel!
    @IBOutlet weak var Choce: UIPickerView!
    @IBOutlet weak var MinTemp: UILabel!
    @IBOutlet weak var MaxTemp: UILabel!
    @IBOutlet weak var WeaterState: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var Feel: UILabel!
    
    @IBOutlet weak var NightToEarly: UILabel!
    @IBOutlet weak var MinTemp1: UILabel!
    @IBOutlet weak var WeaterState1: UILabel!
    @IBOutlet weak var MaxTemp1: UILabel!
    @IBOutlet weak var Feel1: UILabel!
    @IBOutlet weak var Humidity1: UILabel!
    
    @IBOutlet weak var Tomorrow: UILabel!
    @IBOutlet weak var MinTemp2: UILabel!
    @IBOutlet weak var WeaterState2: UILabel!
    @IBOutlet weak var MaxTemp2: UILabel!
    @IBOutlet weak var Humidity2: UILabel!
    @IBOutlet weak var Feel2: UILabel!
    
    var choceName:String!
    
//    var results:WeatherResponse!
    
    var location: String!
    
    var Name = ["宜蘭縣" , "花蓮縣" , "臺東縣" , "澎湖縣" , "金門縣" , "連江縣" , "臺北市" , "新北市" , "桃園市", "臺中市" , "臺南市" , "高雄市" , "基隆市" , "新竹縣" , "新竹市" , "苗栗縣" , "彰化縣" , "南投縣" , "雲林縣" , "嘉義縣" , "嘉義市" , "屏東縣"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
      
//      CallApi(locationName: Name[0])
        Choce.dataSource = self
        Choce.delegate = self
        let image = UIImage(named: "hot.jpeg")
        self.imageIge.image = image
        imageIge.contentMode = .scaleAspectFill
        imageIge.alpha = 0.5
        callApi(location: Name[0])
       
        
        
    }

    func initPercent(string:String) -> URL
        {
            let urlwithPercentEscapes = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
            let url = URL.init(string: urlwithPercentEscapes!)
            return url!
        }
    
    func callApi(location:String) {
        
      
        let request = WeatherRequest(Authorization: "CWB-C1F1124A-2966-4D8B-9E96-BCDECED47A0E",
                                     locationName: "\(location)")
        Task {
            do {
                let results: WeatherResponse = try await NetWorkManager().requestData(method: .get,
                                                 path: .path,
                                                 parameters: request)
                
                let image = UIImage(named: "hot.jpeg")
                self.imageIge.image = image
                imageIge.contentMode = .scaleAspectFill
                imageIge.alpha = 0.5

//                print(results.records.location[0].weatherElement[0].time[0].parameter.parameterValue)
                
                if (1...3 ~= Int(results.records.location[0].weatherElement[0].time[0].parameter.parameterValue ?? "")!) {
                    let image = UIImage(named: "summer.jpeg")
                    self.imageIge.image = image
                    imageIge.contentMode = .scaleAspectFill
                    imageIge.alpha = 0.5
                }
                
                if (4...10 ~= Int(results.records.location[0].weatherElement[0].time[0].parameter.parameterValue ?? "")!) {
                    let image = UIImage(named: "cloudy.jpeg")
                    self.imageIge.image = image
                    imageIge.contentMode = .scaleAspectFill
                    imageIge.alpha = 0.5
                }
                
                if (11...22 ~= Int(results.records.location[0].weatherElement[0].time[0].parameter.parameterValue ?? "")!) {
                    let image = UIImage(named: "ranin.JPG")
                    self.imageIge.image = image
                    imageIge.contentMode = .scaleAspectFill
                    imageIge.alpha = 0.5
                }
                
                if (23 ~= Int(results.records.location[0].weatherElement[0].time[0].parameter.parameterValue ?? "")!) {
                    let image = UIImage(named: "snow.jpg")
                    self.imageIge.image = image
                    imageIge.contentMode = .scaleAspectFill
                    imageIge.alpha = 0.5
                }
                
           
                
                    self.TodayLbl.text = "\(results.records.location[0].weatherElement[0].time[0].startTime) - \(results.records.location[0].weatherElement[0].time[0].endTime)"
                    self.MinTemp.text = "最低溫\(results.records.location[0].weatherElement[2].time[0].parameter.parameterName)"
                    self.MaxTemp.text = "最高溫\(results.records.location[0].weatherElement[4].time[0].parameter.parameterName)"
                    self.WeaterState.text = "\(results.records.location[0].weatherElement[0].time[0].parameter.parameterName)"
                    self.Humidity.text = "濕度\(results.records.location[0].weatherElement[1].time[0].parameter.parameterName)%"
                    self.Feel.text = "\(results.records.location[0].weatherElement[3].time[0].parameter.parameterName)"
                    
                    
                    self.NightToEarly.text = "\(results.records.location[0].weatherElement[0].time[1].startTime) - \(results.records.location[0].weatherElement[0].time[1].endTime)"
                    self.MinTemp1.text = "最低溫\(results.records.location[0].weatherElement[2].time[1].parameter.parameterName)"
                    self.MaxTemp1.text = "最高溫\(results.records.location[0].weatherElement[4].time[1].parameter.parameterName)"
                    self.WeaterState1.text = "\(results.records.location[0].weatherElement[0].time[1].parameter.parameterName)"
                    self.Humidity1.text = "濕度\(results.records.location[0].weatherElement[1].time[1].parameter.parameterName)%"
                    self.Feel1.text = "\(results.records.location[0].weatherElement[3].time[1].parameter.parameterName)"
                    
                    
                    self.Tomorrow.text = "\(results.records.location[0].weatherElement[0].time[2].startTime) - \(results.records.location[0].weatherElement[0].time[2].endTime)"
                    self.MinTemp2.text = "最低溫\(results.records.location[0].weatherElement[2].time[2].parameter.parameterName)"
                    self.MaxTemp2.text = "最高溫\(results.records.location[0].weatherElement[4].time[2].parameter.parameterName)"
                    self.WeaterState2.text = "\(results.records.location[0].weatherElement[0].time[2].parameter.parameterName)"
                    self.Humidity2.text = "濕度\(results.records.location[0].weatherElement[1].time[2].parameter.parameterName)%"
                    self.Feel2.text = "\(results.records.location[0].weatherElement[3].time[2].parameter.parameterName)"
                
                
            } catch {
                print(error)
            }
        }
    }
    
    
    func CallApi(locationName: String) {
        
        let url =  initPercent(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-C1F1124A-2966-4D8B-9E96-BCDECED47A0E&locationName=\(locationName)")
      
       
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
//                return
            }
            if let response = response {
                print(response)
//                return
            }
            let decoder = JSONDecoder()
            if let data = data,
               let results = try? decoder.decode(WeatherResponse.self, from: data) {
                      
    
                DispatchQueue.main.async {
                 
                    self.TodayLbl.text = "\(results.records.location[0].weatherElement[0].time[0].startTime) - \(results.records.location[0].weatherElement[0].time[0].endTime)"
                    self.MinTemp.text = "最低溫\(results.records.location[0].weatherElement[2].time[0].parameter.parameterName)"
                    self.MaxTemp.text = "最高溫\(results.records.location[0].weatherElement[4].time[0].parameter.parameterName)"
                    self.WeaterState.text = "\(results.records.location[0].weatherElement[0].time[0].parameter.parameterName)"
                    self.Humidity.text = "濕度\(results.records.location[0].weatherElement[1].time[0].parameter.parameterName)%"
                    self.Feel.text = "\(results.records.location[0].weatherElement[3].time[0].parameter.parameterName)"
                    
                    
                    self.NightToEarly.text = "\(results.records.location[0].weatherElement[0].time[1].startTime) - \(results.records.location[0].weatherElement[0].time[1].endTime)"
                    self.MinTemp1.text = "最低溫\(results.records.location[0].weatherElement[2].time[1].parameter.parameterName)"
                    self.MaxTemp1.text = "最高溫\(results.records.location[0].weatherElement[4].time[1].parameter.parameterName)"
                    self.WeaterState1.text = "\(results.records.location[0].weatherElement[0].time[1].parameter.parameterName)"
                    self.Humidity1.text = "濕度\(results.records.location[0].weatherElement[1].time[1].parameter.parameterName)%"
                    self.Feel1.text = "\(results.records.location[0].weatherElement[3].time[1].parameter.parameterName)"
                    
                    
                    self.Tomorrow.text = "\(results.records.location[0].weatherElement[0].time[2].startTime) - \(results.records.location[0].weatherElement[0].time[2].endTime)"
                    self.MinTemp2.text = "最低溫\(results.records.location[0].weatherElement[2].time[2].parameter.parameterName)"
                    self.MaxTemp2.text = "最高溫\(results.records.location[0].weatherElement[4].time[2].parameter.parameterName)"
                    self.WeaterState2.text = "\(results.records.location[0].weatherElement[0].time[2].parameter.parameterName)"
                    self.Humidity2.text = "濕度\(results.records.location[0].weatherElement[1].time[2].parameter.parameterName)%"
                    self.Feel2.text = "\(results.records.location[0].weatherElement[3].time[2].parameter.parameterName)"
                    
                }
                      return
                  
            }
                print("impossible")
             
            }.resume()
        }
   
}

extension ChoceCityViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //判斷pickerView的tag值來回傳有幾個component
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //判斷pickerView的tag值以及component來回傳有幾個row
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Name.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //跟numberOfRowsInComponent概念一樣，不過要回傳的是該列要顯示的內容，型別為字串，用row去取得陣列的值
        
        return Name[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //將使用者選到的資料一對應的component跟row取得資料後指定給變數
        choceName = Name[row]
//        CallApi(locationName: choceName)
     callApi(location: choceName)
      
    }
}
