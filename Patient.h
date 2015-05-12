//
//  Patient.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/15/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exam, General, PersonalHx, Symptoms, Vaccinations, Vitals;

@interface Patient : NSManagedObject

@property (nonatomic, retain) General *general;
@property (nonatomic, retain) PersonalHx *personalhx;
@property (nonatomic, retain) NSSet *vaccinations;
@property (nonatomic, retain) NSSet *symptoms;
@property (nonatomic, retain) NSSet *exam;
@property (nonatomic, retain) Vitals *vitals;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addVaccinationsObject:(Vaccinations *)value;
- (void)removeVaccinationsObject:(Vaccinations *)value;
- (void)addVaccinations:(NSSet *)values;
- (void)removeVaccinations:(NSSet *)values;

- (void)addSymptomsObject:(Symptoms *)value;
- (void)removeSymptomsObject:(Symptoms *)value;
- (void)addSymptoms:(NSSet *)values;
- (void)removeSymptoms:(NSSet *)values;

- (void)addExamObject:(Exam *)value;
- (void)removeExamObject:(Exam *)value;
- (void)addExam:(NSSet *)values;
- (void)removeExam:(NSSet *)values;

@end
