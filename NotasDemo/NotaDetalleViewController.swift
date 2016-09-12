//
//  NotaDetalleViewController.swift
//  NotasDemo
//
//  Created by Angel Torres on 12/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//

import UIKit
import CoreData

class NotaDetalleViewController: UIViewController {
    var nota: Notas!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate
            as! AppDelegate).managedObjectContext

    @IBOutlet weak var descripcion: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        descripcion.text = ""
        descripcion.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (nota != nil) {
            descripcion.text = nota.descripcion
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    
        if (nota != nil) {
            nota.descripcion = descripcion.text!
            
        } else {
            let entityDescription = NSEntityDescription.entityForName("Notas", inManagedObjectContext: managedObjectContext)
            nota = Notas(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
            nota.descripcion = descripcion.text!
        }
        
        do {
            try managedObjectContext.save()
            descripcion.text = ""
            
        } catch let error as NSError {
            NSLog("\(error.localizedFailureReason)")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
