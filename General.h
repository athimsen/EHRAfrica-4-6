//
//  General.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/15/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface General : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * dob;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * idnumber;
@property (nonatomic, retain) Patient *patient;

@end
