//
//  Pattern.swift
//  Colortune
//
//  Created by Anna Torlen on 2/28/15.
//  Copyright (c) 2015 Anna Torlen. All rights reserved.
//

import Foundation
import CoreData

class Pattern: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var frontImage: NSData

}
