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
    
    var dataset = [
        ("다크나이트", "영웅물에 철학과 음악을 더해 예술이 되다", "2008-09-04", 8.95, "darknight.jpg"),
        ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
        ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "20015-05-07", 9.19, "secret.jpg")
    ]
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        for (title, desc, opendate, rating, thumbnail) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumbnail = thumbnail
            
            datalist.append(mvo)
        }
        return datalist
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        /* Tag를 사용하여 코드로 각각 연결하는 방식
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        let title = cell.viewWithTag(101) as? UILabel
        let desc = cell.viewWithTag(102) as? UILabel
        let opendate = cell.viewWithTag(103) as? UILabel
        let rating = cell.viewWithTag(104) as? UILabel
        
        title?.text = row.title
        desc?.text = row.description
        opendate?.text = row.opendate
        rating?.text = "\(row.rating!)"
        */
        
        // 위 주석처리된것과 동일한 역할을 수행함.(커스텀 클래스 활용)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        cell.thumbnail.image = UIImage(named: row.thumbnail!) //이미지 캐싱 지원(메모리 이슈가 발생할 수 있으나, IO를 하는데 성능을 향상시킬 수 있음. 그러므로 자주 사용하는 이미지의 경우 이 방식을 체택해야함.
        //
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
}
