//
//  DetailViewController.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/27/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalHxDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *medicalHxLabel;
@property (strong, nonatomic) IBOutlet UILabel *socialHxLabel;
@property (strong, nonatomic) IBOutlet UILabel *familyHxLabel;
@property (strong, nonatomic) IBOutlet UILabel *allergiesLabel;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *dobLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;



@end
