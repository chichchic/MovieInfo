//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by 박시현 on 2019/12/18.
//  Copyright © 2019 박시현. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController {
    
    var page = 1
    var list = [MovieVO]()
    @IBOutlet var moreBtn: UIButton!
    
    @IBAction func more(_ sender: Any) {
        
        self.page += 1
        self.callMovieAPI()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        self.callMovieAPI()
    }
    
    func callMovieAPI() {
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        
        let apidata = try! Data(contentsOf: apiURI)
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result=\(log)")
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            for row in movie {
                let r = row as! NSDictionary
                
                let mvo = MovieVO()
                
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                self.list.append(mvo)
                
                let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
                if (self.list.count >= totalCount) {
                    self.moreBtn.setTitle("마지막 목록입니다.", for: .normal)
                    self.moreBtn.isEnabled = false
                }
            }
        } catch {
            NSLog("Parse Error")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
//        let url: URL! = URL(string: row.thumbnail!)
//        let imageData = try! Data(contentsOf: url)
//        cell.thumbnail.image = UIImage(data: imageData) //이미지 캐싱 지원(메모리 이슈가 발생할 수 있으나, IO를 하는데 성능을 향상시킬 수 있음. 그러므로 자주 사용하는 이미지의 경우 이 방식을 체택해야함.
        cell.thumbnail.image = UIImage(data: try! Data(contentsOf: URL(string: row.thumbnail!)!)) //위 3줄을 한 줄로 쓰기
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
}
