//
//  Vaccinations.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/15/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Vaccinations : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * date;
@property (nonatomic, retain) Patient *patient;

@end
