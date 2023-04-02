//
//  TableController.swift
//  O-B-Dometer
//
//  Created by Connor Critchley on 4/1/23.
//

import UIKit

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableData:UITableView!
    let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData.delegate = self
        tableData.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.shared().stateArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = AppDelegate.shared().stateArray[indexPath.row]
        cell?.detailTextLabel?.text = "Miles: " +  String(AppDelegate.shared().dataArray[indexPath.row])
        return cell!
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
