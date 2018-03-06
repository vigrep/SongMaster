//
//  ViewController.swift
//  SongMaster
//
//  Created by RS-pax on 2017/12/10.
//  Copyright © 2017年 RS-pax. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, AVAudioPlayerDelegate, UIPickerViewDelegate, UITableViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var songTitleTextField: UITextField!;
    
    @IBOutlet weak var mainPlayBar: UISlider!
    @IBOutlet weak var currentDuration: UILabel!
    @IBOutlet weak var totalDuration: UILabel!
    
    @IBOutlet weak var startIndexPlayBar: UISlider!
    @IBOutlet weak var startTimeIntervalLabel: UILabel!;
    @IBOutlet weak var startIndexPlayerBarStepper: UIStepper!;

    @IBOutlet weak var endIndexPlayBar: UISlider!
    @IBOutlet weak var endTimeIntervalLabel: UILabel!;
    @IBOutlet weak var endIndexPlayerBarStepper: UIStepper!;
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var lyricTableView: UITableView!;
    
    @IBOutlet weak var startTextField: UITextField!;
    @IBOutlet weak var endTextField: UITextField!;
    
    var songListPickerView: UIPickerView!;
    var toolBar: UIToolbar!;
    
    
    //播放控制
    var player: AVAudioPlayer!;
    private var playIndex: Int = -1;
    
    //歌词
    private var dataSource: LyricDataSource?;
    //歌名
    private var songListPickerViewDataSource: PickerViewDataSource?;
    

    //播放/暂停
    @IBAction func play(sender: UIButton) {
        if (sender.isSelected != true) {
            play();
            sender.isSelected = true;
            scheduledTimer();
        } else {
            self.player.pause();
            sender.isSelected = false;
            stopTimer();
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (flag) {
            stopTimer();
            playButton.isSelected = false;
        } else {
            
        }
    }
    
    @IBAction func startIndexPlayBarValueChange(sender: UISlider) {
        let startTimeInterval = sliderValueToTimeInterval(sliderValue: sender.value, totalTimeInterval: player.duration);
        let minute = Int(startTimeInterval) / 60;
        let second = Int(startTimeInterval) % 60;
        startTimeIntervalLabel.text = String(format: "%02d:%02d", minute, second);
//        startIndexPlayerBarStepper.value = Double(startIndexPlayBar.value);
    }
    
    @IBAction func endIndexPlayBarValueChange(sender: UISlider) {
        let endTimeInterval = sliderValueToTimeInterval(sliderValue: sender.value, totalTimeInterval: player.duration);
        let minute = Int(endTimeInterval) / 60;
        let second = Int(endTimeInterval) % 60;
        endTimeIntervalLabel.text = String(format: "%02d:%02d", minute, second);
//        endIndexPlayerBarStepper.value = Double(endIndexPlayBar.value);
    }
    
    @IBAction func startIndexPlayBarStepper(sender: UIStepper) {
        startIndexPlayBar.value = Float(sender.value);
        let startTimeInterval = sliderValueToTimeInterval(sliderValue: startIndexPlayBar.value, totalTimeInterval: player.duration);
        let minute = Int(startTimeInterval) / 60;
        let second = Int(startTimeInterval) % 60;
        startTimeIntervalLabel.text = String(format: "%02d:%02d", minute, second);
    }
    
    @IBAction func endIndexPlayBarStepper(sender: UIStepper) {
        endIndexPlayBar.value = Float(sender.value);
        let endTimeInterval = sliderValueToTimeInterval(sliderValue: endIndexPlayBar.value, totalTimeInterval: player.duration);
        let minute = Int(endTimeInterval) / 60;
        let second = Int(endTimeInterval) % 60;
        endTimeIntervalLabel.text = String(format: "%02d:%02d", minute, second);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.startTextField) {
            if let input = textField.text {
                let current = sliderValueToTimeInterval(sliderValue: startIndexPlayBar.value, totalTimeInterval: player.duration);
                let value = timeIntervalToSliderValue(currentTimeInterval: current+Double(input)!, totalTimeInterval: player.duration);
                let startTimeInterval = sliderValueToTimeInterval(sliderValue: value, totalTimeInterval: player.duration);
                let minute = Int(startTimeInterval) / 60;
                let second = Int(startTimeInterval) % 60;
                startTimeIntervalLabel.text = String(format: "%02d:%02d", minute, second);
                startIndexPlayBar.value = Float(value);
            }
        } else if (textField == self.endTextField) {
            if let input = textField.text {
                let current = sliderValueToTimeInterval(sliderValue: endIndexPlayBar.value, totalTimeInterval: player.duration);
                let value = timeIntervalToSliderValue(currentTimeInterval: current+Double(input)!, totalTimeInterval: player.duration);
                let endTimeInterval = sliderValueToTimeInterval(sliderValue: value, totalTimeInterval: player.duration);
                let minute = Int(endTimeInterval) / 60;
                let second = Int(endTimeInterval) % 60;
                endTimeIntervalLabel.text = String(format: "%02d:%02d", minute, second);
                endIndexPlayBar.value = Float(value);
            }
        }
        textField.text="";
        textField.resignFirstResponder();
        return true;
    }
    

    //FIXME
    var dialogRootView: UIView!;
    //保存一句歌词的起始和结束标志位
    @IBAction func saveSongItem(sender: UIButton) {
//        let dialog = SelectSongDialogViewController();
//        let dialogViewController = self.storyboard?.instantiateViewController(withIdentifier: "selectSongListDialog");
//        dialogViewController!.modalPresentationStyle = .custom;
//        dialogViewController!.isModalInPopover = true;
//        present(dialogViewController!, animated: true, completion: nil);
//        dialogViewController?.view.superview?.frame = CGRect(x: 20, y: 20, width: 200, height: 200);
        
        //创建一个全屏的view，透明，然后再其上居中位置添加对话框的view
//        dialogRootView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height));
//        dialogRootView.backgroundColor = UIColor(red: 00, green: 00, blue: 00, alpha: 0.4);
//        //        dialogRootView.alpha = 0.4;
//        let dialogView = UIView(frame: CGRect(x: (self.view.frame.width - 200) / 2, y: (self.view.frame.height - 200) / 2, width: 200, height: 200));
//        dialogView.backgroundColor = UIColor.blue;
//        let button = UIButton(frame: CGRect(x: 20, y: 20, width: 60, height: 60));
//        button.setTitle("登录", for: .normal);
//        button.addTarget(self, action: #selector(ViewController.dismissDialog), for: .touchUpInside);
//        dialogView.addSubview(button);
//        dialogRootView.addSubview(dialogView);
//
//        self.view.addSubview(dialogRootView);
        
        let dialog = ListDialog();
        dialog.setData(data: ["1", "2","3","4","5","6","7","8"]);
        dialog.show(in: self.view);
    }
    
    @objc func dismissDialog() {
        self.dialogRootView.removeFromSuperview();
    }
    
    //从某个位置开始播放
    private func play() {
        let startTimeInterval = sliderValueToTimeInterval(sliderValue: startIndexPlayBar.value, totalTimeInterval: player.duration);
        print("startPlay: \(startTimeInterval) startIndexPlayerBar.value: \(startIndexPlayBar.value)");
        print("startTimeInterval: \(startTimeInterval)");
        player.currentTime = startTimeInterval;
        player.play();
    }
    
    private func timeIntervalToSliderValue(currentTimeInterval: TimeInterval, totalTimeInterval: TimeInterval) -> Float {
        return Float(currentTimeInterval / totalTimeInterval) * 100;
    }
    
    private func sliderValueToTimeInterval(sliderValue: Float, totalTimeInterval: TimeInterval) -> TimeInterval {
        return TimeInterval(Double(sliderValue) * totalTimeInterval / 100);
    }
    
    private func getSongURL(songName: String) -> URL? {
        if let songPath = Bundle.main.url(forResource: songName, withExtension: "mp3") {
            print("songPath: \(songPath)");
            return songPath;
        }
        return nil;
    }

    private func preparePlayer(path: URL) {
        do {
            try player = AVAudioPlayer(contentsOf: path);
            player.prepareToPlay();
            player.delegate = self;
        } catch  {
            print("播放器初始化失败");
        }
    }
    
    //定时器
    var timer: Timer?;
    private func scheduledTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateProgress), userInfo: nil, repeats: true);
    }
    
    private func stopTimer() {
        timer?.invalidate();
    }
    
    private func initView() {
        mainPlayBar.value = Float(0.0);
        startIndexPlayBar.value = Float(0.0);
        endIndexPlayBar.value = Float(100.0);
        
        currentDuration.text = "00:00";
        totalDuration.text = "00:00";
        
        startTextField.delegate = self;
        endTextField.delegate = self;
        
        startTextField.clearButtonMode = .whileEditing;
        endTextField.clearButtonMode = .whileEditing;
        
        lyricTableView.delegate = self;
        
        initSongListPickerView();
//        setupSongListPickerView();//FIXME
    }
    
    var currentMinute = 0;
    var currentSecond = 0;
    
    //初始化歌曲的时长
    private func setDurationLabel() {
        //主播放进度条
        //起始时间
        mainPlayBar.value = 0;
        currentDuration.text = String(format: "%02d:%02d", 0, 0);
        
        //时长
        print("duration: \(player.duration)");
        let duration = Int(player.duration);
        let minute = duration / 60;
        let second = duration % 60;
        totalDuration.text = String(format: "%02d:%02d", minute, second);
        
        //开始时间播放 控制进度条
        startIndexPlayBar.value = 0;
        startTimeIntervalLabel.text = String(format: "%02d:%02d", 0, 0);
        
        //结束时间播放 控制进度条
        endIndexPlayBar.value = 100;
        endTimeIntervalLabel.text = String(format: "%02d:%02d", minute, second);
    }
    
    @objc private func updateProgress() {
        print("currentTime: \(player.currentTime)");
        currentDuration.text = String(format: "%02d:%02d", Int(player.currentTime) / 60, Int(player.currentTime) % 60);
        mainPlayBar.setValue(timeIntervalToSliderValue(currentTimeInterval: player.currentTime, totalTimeInterval: player.duration), animated: true);
        print("mainPlayBar value: \(mainPlayBar.value)");
        
        if (mainPlayBar.value >= endIndexPlayBar.value) {
            play();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView();
        
        //初始化加载第一首歌
        //TODO: 后期可根据最近一次退出时选择的歌曲索引, 来进行初始化
        reloadNewSong(index: 0);
        
        //设置可后台播放
        //1. 设置AudioSession
        //2. info.list : 增加Required background modes , 并增加子项：App plays audio or streams audio/video using AirPlay
        setAudioSession();
    }
    
    private func setAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback);
            try AVAudioSession.sharedInstance().setActive(true);
        } catch {
            print("AVAudioSession 设置失败");
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle);
        print("select \(indexPath.row)");
        let alertController = UIAlertController(title: "提示", message: "信息错误", preferredStyle: .actionSheet);
        alertController.view = nil;
    }
    
    //MARK: 选择歌曲
    func initSongListPickerView() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40));
        let cancelToolBarItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancelTooBarItemClick));
        let doneToolBarItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.doneTooBarItemClick));
        toolBar.barStyle = .blackTranslucent;
        toolBar.setItems([cancelToolBarItem, doneToolBarItem], animated: false);
        
        songListPickerView = UIPickerView(frame: CGRect(x: 0, y: self.view.bounds.height - toolBar.frame.height, width: self.view.bounds.width, height: 200))
        songListPickerView.backgroundColor = UIColor.lightGray;
        songListPickerViewDataSource = PickerViewDataSource(data: LyricManager.songList())
        songListPickerView.dataSource = songListPickerViewDataSource;
        songListPickerView.delegate = self;

        
        print("self: w-Height: \(self.view.bounds.width) - \(self.view.bounds.height)");
        print("picker: w-Height:\(songListPickerView.bounds.width) - \(songListPickerView.bounds.height)")
        print("toolbar: w-Height:\(toolBar.bounds.width) - \(toolBar.bounds.height)")
        print("self: w-Height:\(self.view.bounds)");
        print("pickerView: w-Height:\(songListPickerView.bounds)");
        print("toolbar: w-Height:\(toolBar.bounds)");
        print("self: w-Height:\(self.view.frame)");
        print("pickerView: w-Height:\(songListPickerView.frame)");
        print("toolbar: w-Height:\(toolBar.frame)");
        
        songTitleTextField.inputView = songListPickerView;
        songTitleTextField.inputAccessoryView = toolBar;
    }
    
//    override func updateViewConstraints() {
//        super.updateViewConstraints();
//        let pickerView_width = NSLayoutConstraint(item: songListPickerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 200);
//        //        let pickerView_height = NSLayoutConstraint(item: songListPickerView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0);
//        let pickerView_bottom = NSLayoutConstraint(item: songListPickerView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0);
//        songListPickerView.addConstraint(pickerView_width);
//        self.view.addConstraint(pickerView_bottom);
//    }
    
    func setupSongListPickerView() {
        songListPickerView = UIPickerView();
        songListPickerView.translatesAutoresizingMaskIntoConstraints = false;
//        songListPickerView = UIPickerView(frame: CGRect(x: 0, y: self.view.bounds.height - 162, width: self.view.bounds.width, height: 162))
//        songListPickerViewDataSource = PickerViewDataSource(data: LyricManager.songList())
        songListPickerView.dataSource = songListPickerViewDataSource;
        songListPickerView.delegate = self;
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.bounds.height - songListPickerView.bounds.height, width: self.view.bounds.width, height: 44));
        let cancelToolBarItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancelTooBarItemClick));
        let doneToolBarItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.doneTooBarItemClick));
        toolBar.setItems([cancelToolBarItem, doneToolBarItem], animated: false);
        
        print("self: w-Height: \(self.view.bounds.width) - \(self.view.bounds.height)");
        print("picker: w-Height:\(songListPickerView.bounds.width) - \(songListPickerView.bounds.height)")
        print("toolbar: w-Height:\(toolBar.bounds.width) - \(toolBar.bounds.height)")
        print("self: w-Height:\(self.view.bounds)");
        print("pickerView: w-Height:\(songListPickerView.bounds)");
        print("toolbar: w-Height:\(toolBar.bounds)");
        print("self: w-Height:\(self.view.frame)");
        print("pickerView: w-Height:\(songListPickerView.frame)");
        print("toolbar: w-Height:\(toolBar.frame)");
        
        songTitleTextField.inputView = songListPickerView;
        songTitleTextField.inputAccessoryView = toolBar;
    }
    
    //选择歌曲时，点击取消执行
    @objc func cancelTooBarItemClick() {
        self.songTitleTextField.resignFirstResponder();
    }
    
    //选择歌曲时，点击确定执行
    @objc func doneTooBarItemClick() {
        self.songTitleTextField.resignFirstResponder();
        if (playIndex == self.songListPickerView.selectedRow(inComponent: 0)) {
            return;
        }
        reloadNewSong(index: self.songListPickerView.selectedRow(inComponent: 0));
    }
    
    //MARK: 重新加载一首新歌
    private func reloadNewSong(index: Int) {
        if (playIndex == index || index >= LyricManager.songList().count || index < 0) {
            return;
        }
        playIndex = index;
        
        //释放资源
        if (self.player != nil && self.player.isPlaying) {
            self.player.pause();
            stopTimer();
            playButton.isSelected = false;
        }

        //更新歌名
        let songName = LyricManager.songList()[playIndex];
        updateSongTitle(title: songName);
        
        //初始化播放器
        if let path = getSongURL(songName: songName) {
            preparePlayer(path: path);
            setDurationLabel();
        } else {
            updateSongTitle(title: "歌曲加载失败");
        }
        
        //更新歌词
        dataSource = LyricDataSource(data: LyricManager.getLyricByIndex(index: playIndex));
        lyricTableView.dataSource = dataSource;
        lyricTableView.reloadData();

    }
    
    private func updateSongTitle(title: String) {
        self.songTitleTextField.text = title;
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LyricManager.songList()[row];
    }
    
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 100.0;
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected: \(row)");
    }


}

