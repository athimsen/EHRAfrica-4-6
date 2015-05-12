//
//  Symptoms.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/15/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Symptoms : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSString * other;
@property (nonatomic, retain) Patient *patient;

@end
