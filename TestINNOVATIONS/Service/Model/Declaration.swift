//
//  Declaration.swift
//  TestINNOVATIONS
//
//  Created by dewill on 28.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation
import CoreData

class Declaration: NSManagedObject {
    
    //MARK:-> Create
    static func add(comment:String, id:String,firstName: String, lastName: String, placeOfWork: String, position: String = hasNotPositionText, linkPDF: String = "",  in context: NSManagedObjectContext){
        let declaration =  Declaration(context: context)
        declaration.id = id
        declaration.firstName = firstName
        declaration.lastName = lastName
        declaration.placeOfWork = placeOfWork
        declaration.position = position
        declaration.linkPDF = linkPDF
        declaration.comment = comment
        do{
            _ = try context.save()
        }catch{
            print("Declaration.add ->  \(error)")
        }
    }
    
    //MARK:-> Remove
    static func removeDeclaration(in contex: NSManagedObjectContext){
        
    }
    
    //MARK:-> Update
    static func updateDeclaration(in context: NSManagedObjectContext){
        
    }
    
    //MARK:-> Existing
    static func isExsiting(by id:String, in context:NSManagedObjectContext) -> Bool{
        let request = NSFetchRequest<Declaration>(entityName: "Declaration")
        request.predicate = NSPredicate(format: "id == %@", id)
        do{
            let declarationList = try context.fetch(request)
            return declarationList.count > 0
        }catch {
            print("Declaration getFromDataStore ->  \(error)")
        }
        return false
        
    }
    
}
