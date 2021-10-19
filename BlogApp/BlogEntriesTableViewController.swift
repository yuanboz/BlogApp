//
//  BlogEntriesTableViewController.swift
//  BlogApp
//
//  Created by 周元博 on 10/19/21.
//

import UIKit
import CoreData

class BlogEntriesTableViewController: UITableViewController {

    var BlogEntries : [BlogEntry] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let request: NSFetchRequest<BlogEntry> = BlogEntry.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key:"date", ascending: false)]
            
            if let dataFromCoreData = try? context.fetch(request) as? [BlogEntry] {
                BlogEntries = dataFromCoreData
                tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BlogEntries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let row = tableView.dequeueReusableCell(withIdentifier: "EntryRoll") as? BlogEntryTableViewCell {
            let blogEntry = BlogEntries[indexPath.row]
            // Configure the cell...
            row.contentLabel.text = blogEntry.content
            row.monthTag.text = blogEntry.setMonth()
            row.dayTag.text = blogEntry.setDay()
            
            return row
        } else {
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let blogEntry = BlogEntries[indexPath.row]
        performSegue(withIdentifier: "onEntrySegue", sender: blogEntry)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryViewController = segue.destination as? BlogEntryViewController {
            if let onEntrySubmit = sender as? BlogEntry {
                entryViewController.blogEntry = onEntrySubmit
            }
        }
    }
    
    
    
}
