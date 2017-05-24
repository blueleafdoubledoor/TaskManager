//
//  TaskListTableViewController.swift
//  TaskManager
//
//  Created by 中村明 on 2017/05/24.
//  Copyright © 2017年 bldd. All rights reserved.
//

import UIKit

class TaskListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // タスクのリスト
    var taskLists: [String] = [String]()
    
    // UITableView 操作用変数
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 画面表示時にリスト数を設定する
        for (index, _) in taskLists.enumerated() {
            tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: UITableViewRowAnimation.right)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // テーブルの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskLists.count
    }

    // テーブルの行毎のセルを返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskListCell", for: indexPath)
        // セルの文字列を設定
        cell.textLabel?.text = taskLists[indexPath.row]
        return cell
    }
}
