//
//  ExaminationDetailViewController.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/27/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExaminationDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *bloodGlucoseLabel;
@property (strong, nonatomic) IBOutlet UILabel *bloodPressureLabel;
@property (strong, nonatomic) IBOutlet UILabel *heartRateLabel;
@property (strong, nonatomic) IBOutlet UILabel *respiratoryRateLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *dobLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;

@end
