//
//  DetailViewController.m
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/27/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import "PersonalHxDetailViewController.h"
#import "AppDelegate.h"
#import "GeneralPatientViewController.h"
#import "PersonalHxViewController.h"

@interface PersonalHxDetailViewController ()

@end

@implementation PersonalHxDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluetooth.png"]];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.currentPatient != nil) {
        General *general = [appDelegate.currentPatient valueForKey:@"general"];
        
        float dob = [[general valueForKey:@"dob"] floatValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:dob];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yyyy"];
        
        _fullNameLabel.text = [general valueForKey:@"name"];
        _genderLabel.text = [general valueForKey:@"gender"];
        _dobLabel.text = [formatter stringFromDate:date];
        _heightLabel.text = [NSString stringWithFormat:@"%@ m",[general valueForKey:@"height"]];
        _weightLabel.text = [NSString stringWithFormat:@"%@ kg",[general valueForKey:@"weight"]];
        
//        PersonalHx *personalhx = [appDelegate.currentPatient valueForKey:@"personalhx"];
//        _medicalHxLabel.text = [personalhxInfo setValue:_medhx.text forKey:@"medhx"];
//        
//        
//        
//        [personalhxInfo setValue:_famhx.text forKey:@"famhx"];
//        [personalhxInfo setValue:_allergies.text forKey:@"allergies"];
//        [personalhxInfo setValue:_sochx.text forKey:@"sochx"];
//        @property (strong, nonatomic) IBOutlet UILabel *medicalHxLabel;
//        @property (strong, nonatomic) IBOutlet UILabel *socialHxLabel;
//        @property (strong, nonatomic) IBOutlet UILabel *familyHxLabel;
//        @property (strong, nonatomic) IBOutlet UILabel *allergiesLabel;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
