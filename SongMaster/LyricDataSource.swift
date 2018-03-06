//
//  LyricPickerViewDataSource.swift
//  SongMaster
//
//  Created by RS-pax on 2017/12/16.
//  Copyright © 2017年 RS-pax. All rights reserved.
//

import Foundation
import UIKit

class LyricDataSource: NSObject, UITableViewDataSource {
    
    var dataList:[String];

    init(data: [String]) {
        self.dataList = data;
    }
    
    func setData(data: [String]) {
        self.dataList.removeAll();
        self.dataList.append(contentsOf: data);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath);
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier");
//        if (cell == nil) {
//            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier");
//        }
        cell.textLabel?.text = dataList[indexPath.row];

        return cell;
    }

//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1;
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return dataList.count;
//    }
}
