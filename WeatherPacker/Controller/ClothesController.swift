//
//  ClothesController.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/30/22.
//

import Foundation

class ClothesController:ObservableObject {
    private var clothes:[Item]
    private var temp_max:[Float]
    private var temp_min:[Float]
    private var temp_mean:[Float]
    private var weather_code:[String]
    private var startIndex = 0
    private var endIndex = 0
    private var dailyPackers:[DailyPacker] = []
    
    init() {
        self.clothes = []
        self.temp_max = []
        self.temp_min = []
        self.temp_mean = []
        self.weather_code = []
    }
    
    func createPacker(tripId:UUID, location:String) {
        let packerRepository = PackerRepository()
        packerRepository.add(Packer(id: tripId, location: location, dailyPackers: self.dailyPackers))
    }
        
    
    func generateOutfit() {
        for dateIndex in startIndex..<(endIndex + 1) {
            let itemList:[Item] = generateItem(dateIndex: dateIndex)
            generateDailyPacker(dateIndex: dateIndex, itemList: itemList)
        }
    }
    
    func generateDailyPacker(dateIndex:Int, itemList:[Item]) {
        let highTemp = temp_max[dateIndex]
        let lowTemp = temp_min[dateIndex]
        let weatherCode = weather_code[dateIndex]
        let tripDate = "Day \(dateIndex)"
        var dailyPacker = DailyPacker(id: UUID(), lowTemp: lowTemp, highTemp: highTemp, date: tripDate, weatherCode: weatherCode, itemLists: itemList)
        dailyPackers.append(dailyPacker)
        
    }
    
    func generateItem(dateIndex:Int) -> [Item] {
        print("--------------dateIndex: \(dateIndex)")
        print("--------------temp_mean: \(temp_mean)")
        let temp = temp_mean[dateIndex]
        var itemList:[Item] = []
        if (temp <= -4) {
            let topOutter = Item(id: UUID(), itemTitle: "Winter Jacket", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let topMiddle = Item(id: UUID(), itemTitle: "Sweater", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let topInner = Item(id: UUID(), itemTitle: "Long-sleeves Shirt", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let bottom = Item(id: UUID(), itemTitle: "Winter Pants", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let shoes = Item(id: UUID(), itemTitle: "Winter Boots", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let accessoryFirst = Item(id: UUID(), itemTitle: "Gloves", itemCategory: "Accessory", isChecked: false, itemQuantity: 1)
            let accessorySecond = Item(id: UUID(), itemTitle: "Hats", itemCategory: "Accessory", isChecked: false, itemQuantity: 1)
            itemList.append(topOutter)
            itemList.append(topMiddle)
            itemList.append(topInner)
            itemList.append(bottom)
            itemList.append(shoes)
            itemList.append(accessoryFirst)
            itemList.append(accessorySecond)
        } else if (temp > -4 && temp <= 6) {
            let topOutter = Item(id: UUID(), itemTitle: "Medium Coat", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let topInner = Item(id: UUID(), itemTitle: "Long-sleeves Shirt", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let bottom = Item(id: UUID(), itemTitle: "Jeans", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let shoes = Item(id: UUID(), itemTitle: "Shoes", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            itemList.append(topOutter)
            itemList.append(topInner)
            itemList.append(bottom)
            itemList.append(shoes)
        } else if (temp > 6 && temp <= 17) {
            let topOutter = Item(id: UUID(), itemTitle: "Hoodie", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let topInner = Item(id: UUID(), itemTitle: "T-Shirt", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let bottom = Item(id: UUID(), itemTitle: "Jeans", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let shoes = Item(id: UUID(), itemTitle: "Shoes", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            itemList.append(topOutter)
            itemList.append(topInner)
            itemList.append(bottom)
            itemList.append(shoes)
        } else if (temp > 17 && temp <= 26) {
            let topInner = Item(id: UUID(), itemTitle: "Long-sleeves Shirt", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let bottom = Item(id: UUID(), itemTitle: "Jeans", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let shoes = Item(id: UUID(), itemTitle: "Shoes", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            itemList.append(topInner)
            itemList.append(bottom)
            itemList.append(shoes)
        } else {
            let topInner = Item(id: UUID(), itemTitle: "Short-sleeves Shirt", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let bottom = Item(id: UUID(), itemTitle: "Shorts", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            let shoes = Item(id: UUID(), itemTitle: "Sandals", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
            itemList.append(topInner)
            itemList.append(bottom)
            itemList.append(shoes)
        }
        return itemList
    }
    
    func distancesFrom(_ startingDate: Date, to resultDate: Date) -> Int {
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        let comps = (gregorian as NSCalendar).components(NSCalendar.Unit.day, from: startingDate, to: resultDate, options:.wrapComponents)
        return comps.day!
    }
    
    func calculate_date(startDate:Date,endDate:Date) {
        let currentDate = Date()
        self.startIndex = distancesFrom(currentDate, to: startDate) + 1
        self.endIndex = distancesFrom(currentDate, to: endDate) + 1
        print("______Start Index \(startIndex)")
        print("______Start Index \(endIndex)")
    }
    
    func getWeatherInfo(city:String) {
        print("---------------getWeatherInfor starts")
        let cityToLngAndLatUrl = "https://geocoding-api.open-meteo.com/v1/search?name=\(city)"

        print("---------------getting external API starts")
        
        var lat: Float = 0.0
        var lng: Float = 0.0

        // Your structs go here
        struct Results: Decodable {
          let citys: [City]

          enum CodingKeys : String, CodingKey {
            case citys = "results"
          }
        }

        struct City: Decodable {
          let latitude: Float
          let longitude: Float

          enum CodingKeys : String, CodingKey {
            case latitude = "latitude"
            case longitude = "longitude"
          }
        }

        let searchCityTask = URLSession.shared.dataTask(with: URL(string: cityToLngAndLatUrl)!) { (data, response, error) in
          guard let data = data else {
            print("Error: No data to decode")
            return
          }

          // Decode the JSON here
          guard let result = try? JSONDecoder().decode(Results.self, from: data) else {
            print("Error: Couldn't decode data into a result")
            return
        }


          print("Latitude of \(city) is \(result.citys[0].latitude)")
          print("Longitude of \(city) \(result.citys[0].longitude)")
          lat = result.citys[0].latitude
          lng = result.citys[0].longitude

          
          let weatherForcastUrl = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lng)&hourly=temperature_2m&hourly=weathercode"
          
          struct WeatherForecast: Decodable {
            let hourly: HourlyTemp
            
            enum CodingKeys : String, CodingKey {
              case hourly = "hourly"
            }
          }

          struct HourlyTemp: Decodable {
            let temperature_2m: [Float]
            let code: [Int]

            enum CodingKeys : String, CodingKey {
              case temperature_2m
              case code = "weathercode"
            }
          }

          let searchWeatherTask = URLSession.shared.dataTask(with: URL(string: weatherForcastUrl)!) { (data, response, error) in
            guard let data = data else {
              print("Error: No data to decode")
              return
            }
            
            // Decode the JSON here
            guard let result = try? JSONDecoder().decode(WeatherForecast.self, from: data) else {
              print("Error: Couldn't decode data into a result")
              return
          }
            
            let day1Temp: [Float] = Array(result.hourly.temperature_2m[0...23])
            let day2Temp: [Float] = Array(result.hourly.temperature_2m[24...47])
            let day3Temp: [Float] = Array(result.hourly.temperature_2m[48...71])
            let day4Temp: [Float] = Array(result.hourly.temperature_2m[72...95])
            let day5Temp: [Float] = Array(result.hourly.temperature_2m[96...119])
            let day6Temp: [Float] = Array(result.hourly.temperature_2m[120...143])
            let day7Temp: [Float] = Array(result.hourly.temperature_2m[144...167])
            
              self.temp_min.append(day1Temp.min() ?? 0.0)
              self.temp_min.append(day2Temp.min() ?? 0.0)
              self.temp_min.append(day3Temp.min() ?? 0.0)
              self.temp_min.append(day4Temp.min() ?? 0.0)
              self.temp_min.append(day5Temp.min() ?? 0.0)
              self.temp_min.append(day6Temp.min() ?? 0.0)
              self.temp_min.append(day7Temp.min() ?? 0.0)
              
              self.temp_max.append(day1Temp.max() ?? 0.0)
              self.temp_max.append(day2Temp.max() ?? 0.0)
              self.temp_max.append(day3Temp.max() ?? 0.0)
              self.temp_max.append(day4Temp.max() ?? 0.0)
              self.temp_max.append(day5Temp.max() ?? 0.0)
              self.temp_max.append(day6Temp.max() ?? 0.0)
              self.temp_max.append(day7Temp.max() ?? 0.0)
              
              self.temp_mean.append(Float(Double(day1Temp.reduce(0, +)) / Double(day1Temp.count)))
              self.temp_mean.append(Float(Double(day2Temp.reduce(0, +)) / Double(day1Temp.count)))
              self.temp_mean.append(Float(Double(day3Temp.reduce(0, +)) / Double(day1Temp.count)))
              self.temp_mean.append(Float(Double(day4Temp.reduce(0, +)) / Double(day1Temp.count)))
              self.temp_mean.append(Float(Double(day5Temp.reduce(0, +)) / Double(day1Temp.count)))
              self.temp_mean.append(Float(Double(day6Temp.reduce(0, +)) / Double(day1Temp.count)))
              self.temp_mean.append(Float(Double(day7Temp.reduce(0, +)) / Double(day1Temp.count)))
              
            
            let day1Code: [Int] = Array(result.hourly.code[0...23])
            let day2Code: [Int] = Array(result.hourly.code[24...47])
            let day3Code: [Int] = Array(result.hourly.code[48...71])
            let day4Code: [Int] = Array(result.hourly.code[72...95])
            let day5Code: [Int] = Array(result.hourly.code[96...119])
            let day6Code: [Int] = Array(result.hourly.code[120...143])
            let day7Code: [Int] = Array(result.hourly.code[144...167])
            
              self.weather_code.append(String(day1Code[11]))
              self.weather_code.append(String(day2Code[11]))
              self.weather_code.append(String(day3Code[11]))
              self.weather_code.append(String(day4Code[11]))
              self.weather_code.append(String(day5Code[11]))
              self.weather_code.append(String(day6Code[11]))
              self.weather_code.append(String(day7Code[11]))
              
              print("--------------temp_max: \(self.temp_max)")
              print("--------------temp_min: \(self.temp_min)")
              print("--------------temp_mean: \(self.temp_mean)")
              print("--------------weather code: \(self.weather_code)")
          }

          searchWeatherTask.resume()

        }

        searchCityTask.resume()
    }
}
