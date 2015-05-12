//
//  VaccinationsViewController.h
//  EHRAfrica
//
//  Created by Admin on 4/26/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VaccinationsViewController : UIViewController


@property (strong,nonatomic) IBOutlet UITextField * hepatitisbdate;
@property (strong,nonatomic) IBOutlet UITextField * hepatitisadate;
@property (strong,nonatomic) IBOutlet UITextField * meningitisdate;
@property (strong,nonatomic) IBOutlet UITextField * yellowfdate;
@property (strong,nonatomic) IBOutlet UITextField* typhoidfdate;
@property (strong,nonatomic) IBOutlet UITextField * poliodate;
@property (strong,nonatomic) IBOutlet UITextField * rabiesdate;
@property (strong,nonatomic) IBOutlet UITextField * rotavirusdate;
@property (strong,nonatomic) IBOutlet UITextField * mmrdate;
@property (strong,nonatomic) IBOutlet UITextField * varcelladate;
@property (strong,nonatomic) IBOutlet UIButton * patientProfile;
-(IBAction)textFieldReturn:(id)sender;
@end