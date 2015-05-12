//
//  PersonalHxViewController.h
//  EHRAfrica
//
//  Created by Admin on 4/26/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalHxViewController : UIViewController

@property (strong,nonatomic) IBOutlet UITextField *medhx;
@property (strong,nonatomic) IBOutlet UITextField *famhx;
@property (strong,nonatomic) IBOutlet UITextField *allergies;
@property (strong,nonatomic) IBOutlet UITextField *sochx;
-(IBAction)textFieldReturn:(id)sender;

@end