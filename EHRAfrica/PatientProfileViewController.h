//
//  PatientProfileViewController.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/28/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PatientProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *dobLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
-(IBAction)textFieldReturn:(id)sender;



@end
