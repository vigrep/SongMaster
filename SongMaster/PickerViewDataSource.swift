//
//  SongPickerViewDataSource.swift
//  SongMaster
//
//  Created by RS-pax on 2017/12/16.
//  Copyright © 2017年 RS-pax. All rights reserved.
//

import Foundation
import UIKit

class PickerViewDataSource: NSObject, UIPickerViewDataSource {
    
    private var dataList:[String];
    
    init(data: [String]) {
        self.dataList = data;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count;
    }
    
}
