//
//  LongpressActionTVC.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 09/02/2020.
//  Copyright © 2020 Konrad Łęski. All rights reserved.
//

import Foundation
import UIKit

class LongpressActionTVC : UITableViewController {
    var board : Board?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.dismiss(animated: false, completion: nil)
            self.board?.addTile()
        default:
            print("invalid index")
        }
    }
}
