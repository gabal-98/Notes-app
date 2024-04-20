//
//  ViewController.swift
//  Project 5 ( Notes )
//
//  Created by robusta on 20/04/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var notes = [Note]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
    }

    @objc func addItem(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController {
            vc.completion = { title , description in
                let newNote = Note(title: title, description: description)
                self.notes.append(newNote)
                self.saveNotes()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - tableview data source methods

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].description
        return cell
    }
}

// MARK: - tableview delegate methods

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


struct Note: Codable {
    let title: String
    let description: String
}

