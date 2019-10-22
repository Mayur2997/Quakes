//
//  ViewController.swift
//  Quakes
//
//  Created by Agstya Technologies on 19/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit
import Alamofire

struct QuakesDetail {
    let magValue: Double
    let dateTime: String
    let place: String
}

class ViewController: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var tableVilew: UITableView!
    var arrQuakesDetail = [QuakesDetail]()
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJson()
    }
    
    //MARK:- Other Methods
    func fetchJson() {
        Alamofire.request("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson").responseJSON { (response) in
            if let jsonResponse = response.result.value {
                if let dictQuakeJson = jsonResponse as? [String: Any] {
                    if let arrFeatures = dictQuakeJson["features"] as? [[String: Any]] {
                        for featuresValue in arrFeatures {
                            if let dictProperties = featuresValue["properties"] as? [String: Any] {
                                var place = ""
                                var mag = 0.0
                                var formatedDateTime = ""
                                if let quakeMag = dictProperties["mag"] as? Double {
                                    mag = quakeMag
                                }
                                if let quakePlace = dictProperties["place"] as? String {
                                    place = quakePlace
                                }
                                if let quakeDateTime = dictProperties["time"] as? Int {
                                    let dateTime =  NSDate(timeIntervalSince1970: Double(quakeDateTime) / 1000.0 )
                                    formatedDateTime = self.formatDateTime(dateTime: dateTime)
                                }
                                let strquakesDetail = QuakesDetail(magValue: mag, dateTime: formatedDateTime, place: place)
                                self.arrQuakesDetail.append(strquakesDetail)
                                self.tableVilew.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    //DateFormatter
    func formatDateTime(dateTime: NSDate) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd,yyyy h:mm a"
        return dateFormatterPrint.string(from: dateTime as Date)
    }
}

//MARK:- TableViewController
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQuakesDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblPlace.text = self.arrQuakesDetail[indexPath.row].place
        cell.lblMag.text = String(self.arrQuakesDetail[indexPath.row].magValue)
        cell.lblDateTime.text = self.arrQuakesDetail[indexPath.row].dateTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Quakes", message: self.arrQuakesDetail[indexPath.row].place, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

