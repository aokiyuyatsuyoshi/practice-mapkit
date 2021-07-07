//
//  NextViewController.swift
//  location-map
//
//  Created by Yuya Aoki on 2021/07/07.
//

import UIKit


//textfieldから入力された緯度経度をviewControllerに渡すプロトコル
protocol SearchAdressDelegate {
    func  searchAdress(londitude:String,latitude:String)
}

class NextViewController: UIViewController {
    
    
    //緯度経度のtextfield
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    
    //上で作ったプロトコルを呼び出す
    var SearchAdress:SearchAdressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //searchボタンが押された時の処理
    @IBAction func ActionApply(_ sender: Any) {
        //textfieldから取得した緯度経度を変数に代入
        let LonditudeValue = longitudeTextField.text!
        let LatitudeValue = latitudeTextField.text!
        

        
        //textfieldがどちらとも入力された時のみ画面遷移
        if LonditudeValue != nil && LatitudeValue != nil{
            //これをプロトコルに渡す
            SearchAdress?.searchAdress(londitude: LonditudeValue, latitude: LatitudeValue)
            dismiss(animated: true, completion: nil)
        }
        
    }
    

}
