//
//  NewPatientVisitViewController.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/28/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLE.h"
#import <CoreData/CoreData.h>



@interface NewPatientVisitViewController : UIViewController <BLEDelegate>

{ 

}

@property (strong, nonatomic) IBOutlet UITextField *symptoms;
@property (strong, nonatomic) IBOutlet UITextField *examination;
@property (strong, nonatomic) IBOutlet UITextField *bloodGlucose;
@property (strong, nonatomic) IBOutlet UITextField *bloodPressure;
@property (strong, nonatomic) IBOutlet UITextField *heartRate;
@property (strong, nonatomic) IBOutlet UITextField *respiratoryRate;
@property (strong, nonatomic) IBOutlet UITextField *temperature;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *dobLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
-(IBAction)textFieldReturn:(id)sender;


////////////////////////////////////////
//            readBearLab  BLE
////////////////////////////////////////

// BLE Class Instance
@property (strong, nonatomic) BLE *readBearBLEinstance;

////////////////////////////////////////
//            BLE Interface Elements
////////////////////////////////////////
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorBLE;
//@property (weak, nonatomic) IBOutlet UILabel *labelBLESignal;
@property (weak, nonatomic) IBOutlet UIButton *buttonBLEConnectDisconnect;
- (IBAction)BLEConnectDisconnectButtonPressed:(id)sender;

////////////////////////////////////////
//            Arduino Interface
////////////////////////////////////////
//
//- (IBAction)swTestLED:(id)sender;
//@property (weak, nonatomic) IBOutlet UISwitch *testLEDProperty;
- (IBAction)swTemperaturePin: (id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *swTemperaturePinProperty;

- (IBAction)swHeartRatePin:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *swHeartRatePinProperty;

////////////////////////////////////////
//            Pulse Sensor Interface
////////////////////////////////////////

// Blinking Heart & BPM
//@property (weak, nonatomic) IBOutlet UILabel *labelHeart;
@property (weak, nonatomic) IBOutlet UILabel *labelBPM;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;




@end
