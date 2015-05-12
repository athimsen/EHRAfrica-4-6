//
//  Exam.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/15/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Exam : NSManagedObject

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) Patient *patient;

@end
