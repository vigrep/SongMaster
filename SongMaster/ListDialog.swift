//
//  ListDialog.swift
//  SongMaster
//
//  Created by RS-pax on 2017/12/20.
//  Copyright © 2017年 RS-pax. All rights reserved.
//

import Foundation
import UIKit

class ListDialog: NSObject {
    
    let dialogWidth: Int;
    let itemHeight: Int;
    let dialogMaxHeight: Int;
    let screenWidth: Int;
    let screenHeight: Int;
    
    var containerView: UIView!;
    var dialogView: UIView!;
    var dataList: [String]!;
    
    override init() {
        screenWidth = Int(UIScreen.main.bounds.size.width);
        screenHeight = Int(UIScreen.main.bounds.size.height);
        dialogWidth = screenWidth - 80;
        dialogMaxHeight = screenHeight - 200;
        itemHeight = 40;
        
//        self.initView();
    }
    
    func setData(data: [String]) {
        self.dataList = data;
    }
    
    func initView() {
        if (containerView == nil) {
            createContainerView();
        }
        if dialogView == nil {
            createDialogView();
        }
    }
    
    func createContainerView() {
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight));
        containerView.backgroundColor = UIColor(red: 00, green: 00, blue: 00, alpha: 0.6);
    }
    
    func createDialogView() {
        let dialogHeight = min(dataList.count * itemHeight, dialogMaxHeight);
        let x = (screenWidth - dialogWidth) / 2;
        let y = (screenHeight - dialogHeight) / 2;
        dialogView = UIView(frame: CGRect(x: x, y: y, width: dialogWidth, height: dialogHeight));
        dialogView.backgroundColor = UIColor.white;
        dialogView.layer.shadowRadius = 10;
        let dialogSubView = Bundle.main.loadNibNamed("ListDialogView", owner: nil, options: nil)?.last as! UIView;
        dialogSubView.frame = CGRect(x: 0, y: 0, width: dialogWidth, height: dialogHeight);
        dialogView.addSubview(dialogSubView);
    }
    
    func show(in parentView: UIView) {
        if (containerView == nil) {
            createContainerView();
        }
        if dialogView == nil {
            createDialogView();
        }
        containerView.addSubview(dialogView);
        parentView.addSubview(containerView);
    }
    
    func dismiss() {
        containerView.removeFromSuperview();
    }
}
