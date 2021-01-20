//
//  ViewController.swift
//  Weather
//
//  Created by 刘泉 on 2021/1/19.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
class ViewController: UIViewController{
    //获取用户当前位置
    let locationManager = CLLocationManager()
    let appid = "9dfc4b0eb9f3f9044a375b7c54286f1e"
    let weather = Weather()

    @IBOutlet weak var tempLabel1: UILabel!
    @IBOutlet weak var cityLabel1: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view.
        //获取位置精度，百米
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
     
        //获取用户位置，仅需一次
        locationManager.requestLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated )
        //请求用户位置权限
        locationManager.requestWhenInUseAuthorization()
       
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectCity"{
            let vc = segue.destination as!
                SearchCityController
            vc.currenCity = weather.city
            vc.delegate = self
        }
        
    }
    //请求位置时立刻调用该方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        print(lat,lon)
        let paras = ["lat":"\(lat)","lon":"\(lon)","appid":appid]
        getWeather(paras: paras)
    }
}
extension ViewController:CLLocationManagerDelegate,SelectCityDelegat{
    func didChangeCity(city:String) {
        let paras = ["q":city,"appid":appid ]
        getWeather(paras: paras)
    }
    
    //错误处理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    //获取天气
    func getWeather(paras:[String:String]){
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather",parameters: paras).responseJSON
        { response in
            if let json = response.result.value
            {
                let weather = JSON(json)
                self.creatWeather(weatherJSON: weather)
                self.updateUI()
            }
        }
    }
    //给weather赋值
    func creatWeather(weatherJSON:JSON){
        weather.city = weatherJSON["name"].stringValue
        weather.temp = Int(round(weatherJSON["main","temp"].doubleValue-273.15))
        weather.condition = weatherJSON["weather",0,"id"].intValue
    }
    //更新界面
    func updateUI(){
        cityLabel1.text = weather.city
        tempLabel1.text = "\(weather.temp)℃"
        imageView1.image = UIImage(named:  weather.icon)
    }
}
