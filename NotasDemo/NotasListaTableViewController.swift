//
//  NotasListaTableViewController.swift
//  NotasDemo
//
//  Created by Angel Torres on 11/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//

import UIKit
import CoreData

class NotasListaTableViewController: UITableViewController {
    var notas = [Notas]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "notasDetalle" {
        
            let notaDetalleViewController = segue.destinationViewController as! NotaDetalleViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
        
            notaDetalleViewController.nota = notas[row]
            
        } else if segue.identifier == "anadirNota" {
//            let nota = Notas()
//            nota.descripcion = " "
//            let notaDetalleViewController = segue.destinationViewController as! NotaDetalleViewController
//            notaDetalleViewController.nota = nota
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        cargarNotas()
        
        return notas.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NotasTableCell", forIndexPath: indexPath) as UITableViewCell
        
        let nota = notas[indexPath.row]
        cell.textLabel!.text = nota.descripcion
        return cell
    }
    
     // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            let nota = notas[indexPath.row]
            notas.removeAtIndex(indexPath.row)
            managedObjectContext.deleteObject(nota)
            
            do {
                try managedObjectContext.save()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            } catch let error as NSError {
                NSLog("\(error.localizedFailureReason)")
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func cargarNotas() {
        let entityDescription = NSEntityDescription.entityForName("Notas",
                                                                  inManagedObjectContext: managedObjectContext)
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        do {
            let results = try managedObjectContext.executeFetchRequest(request)
            
            if results.count > 0 {
                notas = results as! [Notas]
                notas = notas.reverse()
            }
            
        } catch let error as NSError {
            NSLog("\(error.localizedFailureReason)")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
