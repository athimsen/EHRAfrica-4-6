//
//  GeneralPatientViewController.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/11/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralPatientViewController : UIViewController

@property (strong,nonatomic) IBOutlet UITextField *fullName;
@property (strong,nonatomic) IBOutlet UITextField *dateOfBirth;
@property (strong,nonatomic) IBOutlet UITextField *gender;
@property (strong,nonatomic) IBOutlet UITextField *height;
@property (strong,nonatomic) IBOutlet UITextField *weight;
-(IBAction)textFieldReturn:(id)sender;

@end

