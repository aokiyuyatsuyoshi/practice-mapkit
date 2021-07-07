//
//  ViewController.swift
//  location-map
//
//  Created by Yuya Aoki on 2021/07/07.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate,SearchAdressDelegate{


    
    //住所を格納する変数
    var Adress = ""
    ///セッティングボタンをコードで操作する変数
    @IBOutlet weak var SettingButtonLayout: UILabel!
    //mapを使うときに必要になる変数
    @IBOutlet weak var mapView: MKMapView!
    //住所を表示する変数
    @IBOutlet weak var AdressLabel: UILabel!
    //長押し下時に操作される変数
    @IBOutlet var LongPush: UILongPressGestureRecognizer!
    //位置情報などを触るときに必要となる変数
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        SettingButtonLayout.backgroundColor = .white
        SettingButtonLayout.layer.cornerRadius = 15.0
    }


    //マップ上で長押しされた時の挙動
    @IBAction func ActionLongPush(_ sender: UILongPressGestureRecognizer) {
        //推し始めたとき
        if sender.state == .began{
            
        }
        //推し終えた時
        else if sender.state == .ended{
            
            //タップした位置を取得
            let TapPoint = sender.location(in: view)
            //マップからタップした位置の情報を取得
            let center = mapView.convert(TapPoint, toCoordinateFrom: mapView)

            //緯度経度をcenterから取得
            let latitude = center.latitude
            let longitude = center.longitude
        

            //マップから取得した緯度経度を住所に変換する
            ConvertToAdress(latitude: latitude, longitude: longitude)
        }
    }
    
    //緯度経度を住所に変換する関数
    func ConvertToAdress(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
        
        //位置情報使えるようにする
        let Geocoder = CLGeocoder()
        let Location = CLLocation(latitude: latitude, longitude: longitude)
        
        //placemarkに値が入ってきた時に県や市などを表示し、名所などはその名前だけ表示する
        Geocoder.reverseGeocodeLocation(Location){
            (placeMark,error) in
            if let placeMark = placeMark{
                if let pm = placeMark.first{
                    if pm.administrativeArea != nil||pm.locality != nil{
                        self.Adress = pm.name! + pm.administrativeArea! + pm.locality!
                    }else{
                        self.Adress = pm.name!
                    }
                    
                    self.AdressLabel.text = self.Adress
                }
            }
        }
        
    }
    
    
    //画面遷移
    @IBAction func GotoNextVC(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let nextVC = segue.destination as! NextViewController
            nextVC.SearchAdress = self
        }
        
    }
    
    //入力された緯度経度をMapに表示
    func searchAdress(londitude: String, latitude: String) {
        //コーディネートを設定
        let coordinate = CLLocationCoordinate2DMake(Double(londitude)!, Double(latitude)!)
        
        //範囲を指定
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        //領域を指定
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        //実際にMapへ表示する
        mapView.setRegion(region, animated: true)
        
    
        //lonとlatがバグって変なことになってるので対処法としてこれ
        ConvertToAdress(latitude: Double(londitude)!, longitude: Double(latitude)!)
        
        
    }
    
    
}

