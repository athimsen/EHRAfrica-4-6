//
//  Vitals.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/15/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Vitals : NSManagedObject

@property (nonatomic, retain) NSNumber * temperature;
@property (nonatomic, retain) NSNumber * heartrate;
@property (nonatomic, retain) NSNumber * resprate;
@property (nonatomic, retain) NSNumber * bloodpres;
@property (nonatomic, retain) NSNumber * bloodgluc;
@property (nonatomic, retain) Patient *patient;

@end
