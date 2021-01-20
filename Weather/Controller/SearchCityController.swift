//
//  SearchCityController.swift
//  Weather
//
//  Created by 刘泉 on 2021/1/20.
//

import UIKit
protocol SelectCityDelegat {
    func didChangeCity(city:String)
}
class SearchCityController: UIViewController {
    
    var currenCity = "111"
    var delegate:SelectCityDelegat?
    
    
    @IBOutlet weak var cityinput: UITextField!
    @IBAction func changeCity(_ sender: Any) {
        delegate?.didChangeCity(city: cityinput.text!)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backMain1(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var CityLabel2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        CityLabel2.text = currenCity
        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

}
