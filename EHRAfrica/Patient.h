//
//  Patient.h
//  
//
//  Created by Alec Thimsen on 4/11/15.
//
//

#import "General.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Patient : NSManagedObject

- (void)setGeneralInfo:(General *)general;

@end
