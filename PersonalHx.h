//
//  PersonalHx.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/15/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface PersonalHx : NSManagedObject

@property (nonatomic, retain) NSString * medhx;
@property (nonatomic, retain) NSString * famhx;
@property (nonatomic, retain) NSString * allergies;
@property (nonatomic, retain) NSString * sochx;
@property (nonatomic, retain) Patient *patient;

@end
