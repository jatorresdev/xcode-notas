//
//  Notas+CoreDataProperties.h
//  NotasDemo
//
//  Created by Angel Torres on 9/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Notas.h"

NS_ASSUME_NONNULL_BEGIN

@interface Notas (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *descripcion;

@end

NS_ASSUME_NONNULL_END
