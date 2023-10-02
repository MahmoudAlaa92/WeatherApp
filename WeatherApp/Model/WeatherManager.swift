
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateData(_ weatherManager: WeatherManager ,weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=47ca0127410125d99c0a0ca8c6783d76&units=metric"
    
    var delegata : WeatherManagerDelegate?
    
    func fetchWeather (cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequist(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequist(with: urlString)
    }
    
    func performRequist(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if (error != nil){
                    self.delegata?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegata?.didUpdateData(self ,weather: weather)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let date = decodedData.dt
            let description = decodedData.weather[0].description
            let humidity = decodedData.main.humidity
            let windDegree = decodedData.wind.deg
            let windSpeed  = decodedData.wind.speed
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, date: date, descriptionWeather: description, humidityWeather: humidity, windDeg: windDegree, windSpeed: windSpeed)
            return weather
            
        }catch{
            delegata?.didFailWithError(error: error)
            return nil
        }
    }
    
    
  
}
