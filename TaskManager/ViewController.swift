//
//  ViewController.swift
//  TaskManager
//
//  Created by bldd on 2017/05/23.
//  Copyright © 2017年 bldd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // ラベルの文字列定数
    let INIT_LABEL_TEXT = "タスク開始"
    // ボタンのタイトルに使用する文字列定数
    let INIT_BTN_TEXT = "START"

    // タスク名
    var taskName: [String] = [String]()
    // タスクの開始時間
    var taskStart: Date!
    // タスクの終了時間
    var taskEnd: Date!
    // ボタンの状態
    var isStartTaks: Bool = false
    // タイマー
    var timer: Timer!
    // レイアウトしたラベル
    @IBOutlet weak var mainLabel: UILabel!
    // レイアウトしたタスク用ボタン
    @IBOutlet weak var taskButton: UIButton!
    // レイアウトしたリスト用ボタン
    @IBOutlet weak var listButton: UIButton!

    // 画面の初期化処理を行う
    override func viewDidLoad() {
        super.viewDidLoad()
        // ラベルの初期化
        mainLabel.text = INIT_LABEL_TEXT
        mainLabel.textColor = UIColor.blue
        // タスク用ボタンの初期化
        taskButton.setTitle(INIT_BTN_TEXT, for: .normal)
        taskButton.backgroundColor = UIColor.blue
        taskButton.setTitleColor(UIColor.white, for: .normal)
        // 角を丸くする
        taskButton.layer.cornerRadius = 10
        listButton.layer.cornerRadius = 10
        // ボタン押下時にアニメーションさせない
        UIButton.setAnimationsEnabled(false)
        // ボタンの状態を初期化
        isStartTaks = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 時間を文字列で取得
    func getTime(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm:ss"
        return format.string(from: date)
    }
    
    // タイマーを更新する
    func timerUpdate() {
        // メッセージ内容を更新
        mainLabel.text = getTime(date: Date())
        mainLabel.textColor = UIColor.black
    }

    // タスクボタン処理関数
    @IBAction func taskButtonFunc(_ sender: Any) {
        if !isStartTaks {
            isStartTaks = true
            // 開始時間を取得
            taskStart = Date()
            // タイマーを更新
            timerUpdate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
            // ボタンの表示を切り替える
            taskButton.setTitle("STOP", for: .normal)
            taskButton.backgroundColor = UIColor.red
        }
        else {
            isStartTaks = false
            // 終了時間
            taskEnd = Date()
            // デフォルトのタスク名
            let name = getTime(date: taskStart) + " ~ " + getTime(date: taskEnd)
            taskName.append(name)
            // タスクの時間を登録するために UserDefaults のインスタンスを取得
            // タイマーを止める
            timer.invalidate()
            
            // 初期化
            taskButton.setTitle(INIT_BTN_TEXT, for: .normal)
            taskButton.backgroundColor = UIColor.blue
            mainLabel.text = INIT_LABEL_TEXT
            mainLabel.textColor = UIColor.blue
        }
    }
    
    // タスク名を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskListTable = segue.destination as! TaskListTableViewController
        taskListTable.taskLists = taskName
    }
}
