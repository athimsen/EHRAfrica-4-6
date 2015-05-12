//
//  NewPatientVisitViewController.m
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/28/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import "NewPatientVisitViewController.h"
#import "AppDelegate.h"
#import "Patient.h"
#import "Vitals.h"

@interface NewPatientVisitViewController () <UITextFieldDelegate>{





#pragma public properties and variables
    
    
    // PulseSensor BPM Elements
    NSMutableArray *beatsHappenedTimeStampedArray;
    NSMutableArray *beatQualifyArray;
    int counter;
    
    
    // For HardCoding Part of Code
    //    NSString *myBlueSheildUUID;
    //    CBUUID * myUUIDA;
    //    CBUUID * foundUUIDA;
    
}
@property (nonatomic) NSInteger selectedFieldTag;


@end

@implementation NewPatientVisitViewController



-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

//- (IBAction)saveNewPatient {
//    Vitals* (^createNewPersonalHxInfo)() = ^()
//    
//    {
//        Vitals *vitals = [NSEntityDescription insertNewObjectForEntityForName:@"Vitals" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
//        
//       [vitalsInfo setValue:[NSDecimalNumber decimalNumberWithString:_height.text] forKey:@"temperature"];
//        
//        [personalhxInfo setValue:_medhx.text forKey:@"temperature"];
//        [personalhxInfo setValue:_famhx.text forKey:@"heartrate"];
//        [personalhxInfo setValue:_allergies.text forKey:@"resprate"];
//        [personalhxInfo setValue:_sochx.text forKey:@"bloodpres"];
//         [personalhxInfo setValue:_sochx.text forKey:@"bloodgluc"];
//        
//        
//        return vitalsInfo;
//    };
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    Patient *newPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
//    Vitals *vitals = createNewPersonalHxInfo();
//    
//    [vitals setValue:newPatient forKey:@"patient"];
//    
//    [newPatient setValue:vitals forKey:@"vitals"];
//    
//    id globalStore = [[[appDelegate managedObjectContext] persistentStoreCoordinator] persistentStoreForURL:appDelegate.storeUrl];
//    
//    [[appDelegate managedObjectContext] assignObject:newPatient toPersistentStore:globalStore];
//    
//    [[appDelegate managedObjectContext] assignObject:personalhx toPersistentStore:globalStore];
//    
//    [appDelegate.patientLookupById setObject:newPatient forKey:[vitals valueForKey:@"idnumber"]];
//    NSString *name = [vitals valueForKey:@"name"];
//    [appDelegate.patientLookupByName setObject:newPatient forKey:[name lowercaseString]];
//    appDelegate.currentPatient = newPatient;




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma private intance variables

/////////////////////////////////////
//  BLE Class and Interface Elements
/////////////////////////////////////
@synthesize readBearBLEinstance,buttonBLEConnectDisconnect,activityIndicatorBLE;
//labelBLEMessageAndUUID,progressViewBLEsignal,activityIndicatorBLE, labelBLEName, labelBLESignal;

/////////////////////////////////////
// Arduino Interface Elements
/////////////////////////////////////
@synthesize swHeartRatePinProperty, swTemperaturePinProperty;//testLEDProperty,

/////////////////////////////////////
//  PulseSensor Interface Elements
/////////////////////////////////////
@synthesize labelBPM, labelTemp;
//labelPulseSensorRawSignal,labelAmplitude,labelPeak,labelThreshold,labelTrough, labelHeart;
//@synthesize progressBarPulseSensorSignal,progressBarAmp,progressBarPeak,progressBarThreshold, progressBarTrough;

/////////////////////////////////////
//  Vars for - (void)PulseSensorFullCode
/////////////////////////////////////

Boolean Pulse = false;
Boolean RealQualifiedBeat = false;
int PulseSensorValue;
int Signal;
int Trough = 512;
int Peak = 512;
int Threshold = 512;
int Amplitude = 100;

int beatsSampleCounter = 0;

/////////////////////////////////////
#pragma View Did Load
/////////////////////////////////////

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluetooth.png"]];
//
//    -(IBAction)textFieldReturn:(id)sender
//    {
//        [sender resignFirstResponder];
//    }

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
            
            
            
        }
    
    
    
    
    // Create an Instance of BLE from Red Bear Lab's Framework
    readBearBLEinstance = [[BLE alloc]init];
    [readBearBLEinstance controlSetup:1];   // not sure ??
    readBearBLEinstance.delegate = self;    // set Instance Delegate to self this ViewController
    
    // Setup BLE Interface Elements
    //    [labelBLEMessageAndUUID setText:@"Not Connected to Any BLE Device"];
    //    [progressViewBLEsignal setProgress:0.0];
    //    counter = 0;
    //    [labelBLEName setText:@""];
    //    [labelBLESignal setText:@""];
    
    //  Setup Arduino Interface Elements
    //    [testLEDProperty setOn:NO animated:YES];
    [swHeartRatePinProperty setOn:NO animated:YES];
    [swTemperaturePinProperty setOn:NO animated:YES];
    //    [progressBarPulseSensorSignal setProgress:0.05];
    
    //    // Setup PS Interface Elements
    //    [self resetAllPulseSensorVariables];
    //    [self updateLabelsPulseSensorInterfaceElements];
    
    
    // Setup PS BPM Elements
    beatsHappenedTimeStampedArray = [@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]mutableCopy];
    beatQualifyArray = [@[@"0",@"0"]mutableCopy];
    beatQualifyArray[0]= [NSDate date];
    
    
    //    [self printArray];   // for debugging
    //    [labelHeart setAlpha:0.2];
    //    [labelHeart setTextColor:[UIColor redColor]];
    
}

-(void) resetBeatsHappenedTimeStampedArray{
    for (int i = 0; i<9; i++) {
        beatsHappenedTimeStampedArray[i]= @"0";
    }
    beatsSampleCounter = 0;
}


/////////////////////////////////////
# pragma mark BLE Interface
/////////////////////////////////////

- (IBAction)BLEConnectDisconnectButtonPressed:(id)sender {
    
    //  IF ALREADY CONNECTED
    if (readBearBLEinstance.activePeripheral){
        if (readBearBLEinstance.activePeripheral.isConnected) {
            
            // iPhone is Connected, Tell it to Disconnect
            [[readBearBLEinstance CM] cancelPeripheralConnection:readBearBLEinstance.activePeripheral];
            
            //  Do Interface Changes on Disconnect
            [buttonBLEConnectDisconnect setTitle:@"Connect to BLE Device" forState:UIControlStateNormal];
            
            //            [labelBLEMessageAndUUID setText:@"Not Connected To BLE Peripheral"];
            //            [progressViewBLEsignal setProgress:0.0 animated:YES];
            [labelBPM setText:@" -- "];
            //            [self resetAllPulseSensorVariables];
            
            return;
        }
    }
    // Clear out any Peripherals if they exist
    if (readBearBLEinstance.peripherals) {
        readBearBLEinstance.peripherals = nil;
    }
    
    //  Go Do BLE Scanning
    [readBearBLEinstance findBLEPeripherals:2];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    [activityIndicatorBLE startAnimating];
    [buttonBLEConnectDisconnect setTitle:@"Scanning" forState:UIControlStateNormal];
    //    [labelBLEMessageAndUUID setText:@"Scanning..."];
}



/////////////////////////////////////
#pragma BLE Delegate Calls
/////////////////////////////////////

-(void) bleDidConnect{
    NSLog(@"bleDidConnected");
    
    //reset Pulse Sensor Display
    //    [self resetAllPulseSensorVariables];
    //    [self resetPulseSensorAlgoVariables];   //Yury Moved Out to fix Bug on Restart
    //    [self updateLabelsPulseSensorInterfaceElements];
    
    
    // BLE Interface
    //Labels
    //    [labelBLEMessageAndUUID setText:[NSString stringWithFormat:@"UUID: %s",[readBearBLEinstance UUIDToString:readBearBLEinstance.activePeripheral.UUID]]];
    //    [labelBLEName setText:[NSString stringWithFormat:@"BLE Name: %s",[readBearBLEinstance.activePeripheral.name cStringUsingEncoding:NSStringEncodingConversionAllowLossy ]]];
    //    [labelBLESignal setText:@"BLE Signal:"];
    
    //Connect Button
    [buttonBLEConnectDisconnect setTitle:@"Disconnect" forState:UIControlStateNormal];
    [activityIndicatorBLE stopAnimating];
    [activityIndicatorBLE setHidesWhenStopped:YES];
    
    //Pulse Sensor Interface
    [swHeartRatePinProperty setOn:YES animated:YES ];
    [self swHeartRatePin:swHeartRatePinProperty];
    
    //Temp Sensor Interface
    [swTemperaturePinProperty setOn:YES animated:YES ];
    [self swHeartRatePin:swTemperaturePinProperty];
}

-(void) bleDidDisconnect{
    NSLog(@"bleDidDisconnect");
    
    //reset Pulse Sensor Display
    //    [self resetAllPulseSensorVariables];
    //    [self updateLabelsPulseSensorInterfaceElements];
    //    [progressBarPulseSensorSignal setProgress:0.00 animated:YES];
    //    [progressViewBLEsignal setProgress:0.0 animated:YES];
    [swHeartRatePinProperty setOn:NO animated:YES ];
    [swTemperaturePinProperty setOn:NO animated:YES ];
    //    [testLEDProperty setOn:NO animated:YES];
    
    //
    //    [labelBLEMessageAndUUID setText:@"Disconnected from BLE Device "];
    //    [labelBLEName setText:@""];
    //    [labelBLESignal setText:@""];
    [activityIndicatorBLE stopAnimating];
    [activityIndicatorBLE setHidesWhenStopped:YES];
    [buttonBLEConnectDisconnect setTitle:@"Connect To BLE Device" forState:UIControlStateNormal];
    
    
    
    
}

//-(void) bleDidUpdateRSSI:(NSNumber *)rssi{
//
//    float rssiInFloat = [rssi floatValue];
//    //  formula just to display a representive progress view to rssi value
//    rssiInFloat = (rssiInFloat + 135) * .01 ;
////    [progressViewBLEsignal setProgress:rssiInFloat animated:YES];
//
//    //   NSLog(@"RSSI float %f", rssiInFloat);
//}
//
-(void) bleDidReceiveData:(unsigned char *)data length:(int)length{
    for (int i = 0; i<length; i+=3) {
        
        if (data[i] == 0x0B) {
            UInt16 Value;
            Value = data[i+2] | data[i+1] << 8;
            
            //Pulse Sensor Intderface
            //            [labelPulseSensorRawSignal setText:[NSString stringWithFormat:@"Pulse Signal: %d",Value]];
            //   NSLog(@"value is %d and float is %f", Value, Value*0.001 );
            
            PulseSensorValue = Value;
                        [self PulseSensorFullCode:PulseSensorValue];
            //            [progressBarPulseSensorSignal setProgress:Value*0.001 animated:NO];
            
            
            
        }
    }
}



/////////////////////////////////////
#pragma Functions Called by Timers
/////////////////////////////////////

-(void) connectionTimer:(NSTimer *)timer
{
    [buttonBLEConnectDisconnect setEnabled:true];
    [buttonBLEConnectDisconnect setTitle:@"Disconnect" forState:UIControlStateNormal];
    
    if (readBearBLEinstance.peripherals.count > 0)
    {
        [readBearBLEinstance connectPeripheral:[readBearBLEinstance.peripherals objectAtIndex:0]];
    }
    else
    {
        [buttonBLEConnectDisconnect setTitle:@"Connect" forState:UIControlStateNormal];
        [activityIndicatorBLE stopAnimating];
    }
}

//-(void) connectionTimer: (NSTimer *)timer{
//
//    if (readBearBLEinstance.peripherals.count >0)
//    {
//
//        //  REMOVE COMMENT TO CONNECT TO FIRST AVAILABLE DEVICE
//        //  [readBearBLEinstance connectPeripheral:[readBearBLEinstance.peripherals objectAtIndex:0]];
//
//        // THIS HARD-CODES UUID OF ONE RED BEAR BLE DEVICE
//
//
//
////        for(int i = 0; i < readBearBLEinstance.peripherals.count; i++)
////        {
////            //////////////////////////////////////////////////////////
////            //  PUT YOUR BLE SHEILD UUID HERE, Check DeBug Log Below For Available UUID's
//            // example:  @"A1834B4A-CEF2-AD8B-A13F-20616683B36E";
//            //////////////////////////////////////////////////////////
//
////            myBlueSheildUUID = @"A1834B4A-CEF2-AD8B-A13F-20616683B36E";
////            myUUIDA = [CBUUID UUIDWithString:myBlueSheildUUID];
//
//
////            CBPeripheral *p = [readBearBLEinstance.peripherals objectAtIndex:i];
////            NSMutableString * pUUIDString = [[NSMutableString alloc] initWithFormat:@"%@",CFUUIDCreateString(NULL, p.UUID) ];
////            // Debug Line
////            // NSLog(@"\n++++++\nLooking for your perfered Device UUID of: %@\n", myBlueSheildUUID);
////
////            // Debug Line
////            //NSLog(@" pUUIDString is: %@\n", pUUIDString);
////
//////            if ([myBlueSheildUUID isEqualToString:pUUIDString]) {
//////                NSLog(@"\n\n++++++   Found your Perfered Device UUID of: %@\n\n", myBlueSheildUUID);
////                [readBearBLEinstance connectPeripheral:[readBearBLEinstance.peripherals objectAtIndex:i]];
////                [ labelBLEMessageAndUUID setText:[NSString stringWithFormat:@"%s",[readBearBLEinstance UUIDToString:readBearBLEinstance.activePeripheral.UUID]]];
////
////
////            }
////            if (![myBlueSheildUUID isEqualToString:pUUIDString]) {
////                NSLog(@"Found a Bluetooth Device, But doesn't match your UUID \n\n");
////                [ labelBLEMessageAndUUID setText:[NSString stringWithFormat:@"Found Bluetooth Device, Doesn't ur coded UUID"]];
////
////
////            }
////
////
////        }
////
//
//
//
//
//
//
//    }
//    else
//    {
//        [labelBLEName setText:@""];
//        [labelBLESignal setText:@""];
//
//        if (counter <= 1){
//            [labelBLEMessageAndUUID setText:@"No BLE Device found, Try To Connect Again"];
//            //  [labelBLEMessageAndUUID setTextColor:[UIColor blueColor]];
//
//        }
//        if (counter > 1 ) {
//            [labelBLEMessageAndUUID setText:@"Still No Luck, Try Power Cycling the BLE Device"];
//            //  [labelBLEMessageAndUUID setTextColor:[UIColor redColor]];
//            counter = 0;
//        }
//
//        counter = counter + 1;
//        NSLog(@"counter= %i",counter);
//
//        [buttonBLEConnectDisconnect setTitle:@"Connect to BLE Device" forState:UIControlStateNormal];
//        [activityIndicatorBLE stopAnimating];
//    }
//}
//
-(void) pulseSensorReadingsResetTimer: (NSTimer*) timer {

    NSDate* lastBeatTime = beatQualifyArray[9];
    NSDate* timeNow = [NSDate date];
    NSDate* time7secondsEarlier = [timeNow dateByAddingTimeInterval:-7 ];

    if ([lastBeatTime isEqualToDate:[lastBeatTime earlierDate:time7secondsEarlier]]) {
        NSLog(@"lastBeatTime happened more then 7 seconds ago, reset PS Algo Vars");
//        [self resetAllPulseSensorVariables];
//
    }
}



/////////////////////////////////////
#pragma Arduino Interface Elements
/////////////////////////////////////

//- (IBAction)swTestLED:(id)sender {
//
//    if(testLEDProperty.on){
//        [self blinkLEDPin4ON];
//
//    }  else {
//        [self blinkLEDPin4OFF];
//
//    }
//
//}



/////////////////////////////////////
#pragma Pulse Sensor Interface Elements
/////////////////////////////////////

- (IBAction)swTemperaturePin:(id)sender
{

}

- (IBAction)swHeartRatePin:(id)sender {
    UInt8 buf[3] = {0xA0, 0x00, 0x00};
    
    if (swHeartRatePinProperty.on) {
        buf[1] = 0x01;
                [self resetAllPulseSensorVariables];
        
        [self updateLabelsPulseSensorInterfaceElements];
        
    }
    else if (!swHeartRatePinProperty.on){
        buf[1] = 0x00;
        [self resetBeatsHappenedTimeStampedArray];
                [self resetAllPulseSensorVariables];
        [self updateLabelsPulseSensorInterfaceElements];
        
        //    [self resetPulseSensorAlgoVariables];
    }
    
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    
    [readBearBLEinstance write:data];
}



/////////////////////////////////////
#pragma Pulse Sensor Algo Code
/////////////////////////////////////

- (void)PulseSensorFullCode: (int)PSValueToCalculate
{
    
    
    /// Find, set, keep Peak and Trough of Raw Pulse Sensor Signal
    
    Signal = PSValueToCalculate;
    
    if (Signal < Trough){                        // T is the trough
        Trough = Signal;                         // keep track of lowest point in pulse wave
    }
    
    
    if((Signal > Threshold && Signal > Peak) ){       // thresh condition helps avoid noise
        Peak = Signal;                             // P is the peak
    }                                              // keep track of highest point in pulse wave
    
    
    // new edge case
    if (Signal < Peak && Signal > Threshold) {
        Amplitude = Peak - Trough;                 //  get Amp of Pulse Wave
        Threshold = Amplitude/2 + Trough;       // set the Thresholdat 50% of Amp
        Peak = Threshold;                          //reset for next time
        Trough = Threshold;
        
    }
    
    // //  NOW IT'S TIME TO LOOK FOR THE HEART BEAT
    // signal surges up in value every time there is a pulse
    
    if ((Signal > Threshold) && (Pulse == false)) {
        
        [self qualifyBeat];
        
        if (RealQualifiedBeat) {
            Pulse = true;      // Pulse Happened, set the Pulse flag
            //            [self beatDetectedDoInterfaceStuff];
            [self calculateBPM];
        }
        
        
    }
    
    
        if (Signal < Threshold && Pulse == true) {
    
            //   if (Pulse == true) {
    
           // [self blinkLEDPin4OFF];     // when the values are going down, the beat is over, turn off pin 13 LED
            //[labelHeart setAlpha:0.2];
    
            Pulse = false;                          // reset Pulse Flag
            Amplitude = Peak - Trough;                 //  get Amp of Pulse Wave
            Threshold = Amplitude/2 + Trough;       // set the Thresholdat 50% of Amp
            Peak = Threshold;                          //reset for next time
            Trough = Threshold;
        }
    
    
    
    // new edge case
    if (Signal > Threshold && Signal > Trough  && Pulse == true) {
        
        
        //      [self blinkLEDPin4OFF];     // when the values are going down, the beat is over, turn off pin 13 LED
        //      [labelHeart setAlpha:0.2];
        
        //      Pulse = false;                          // reset Pulse Flag
        //      Amplitude = Signal - Trough;  //NEW               //  get Amp of Pulse Wave
        //      Threshold = Amplitude/2 + Trough;       // set the Thresholdat 50% of Amp
        //    Peak = Threshold;                          //reset for next time
        //    Trough = Threshold;
    }
    
    
    
    
    
    
    [self updateLabelsPulseSensorInterfaceElements];
    
    
}

//-(void) beatDetectedDoInterfaceStuff{
//
//    [self blinkLEDPin4ON];
//
//    [labelHeart setAlpha:1.0];
//    [labelHeart setTextColor:[UIColor redColor]];
//[labelHeart setText:@"❤"];

//}

-(void) qualifyBeat{
    
    static float timeBetweenBeats = 1.0;
    static float timeSinceLastBeat;
    beatQualifyArray[1]=[NSDate date];
    
    
    timeBetweenBeats = [beatQualifyArray[1] timeIntervalSinceDate:beatQualifyArray[0]];
    NSLog(@"timeBetweenBeats is = %f",timeBetweenBeats);
    
    //    if (timeBetweenBeats > timeSinceLastBeat+0.20  || timeBetweenBeats < timeSinceLastBeat-0.20 || timeBetweenBeats < 0.5 || timeBetweenBeats > 1.3) {
    if (timeBetweenBeats < 0.5 || timeBetweenBeats > 1.3) {
        RealQualifiedBeat = FALSE;
        NSLog(@"RealQualifiedBeat is FALSE");
    } else{
        RealQualifiedBeat = TRUE;
        NSLog(@"RealQualifiedBeat is TRUE");
        
    }
    timeSinceLastBeat = timeBetweenBeats;
    
    [beatQualifyArray replaceObjectAtIndex:0 withObject:beatQualifyArray[1]];
    //beatQualifyArray[0] = beatQualifyArray[1];
}

-(void) calculateBPM{
    float timeBetweenTenBeats;
    int BPM;
    int static lastBPM = 75;
    beatsSampleCounter++;
    
    //    NSLog(@"---Before Array Shift---");
    //    [self printArray];
    
    for (int i = 0; i <9; i++) {
        [beatsHappenedTimeStampedArray replaceObjectAtIndex:i withObject:beatsHappenedTimeStampedArray [i+1]];
    }
    
    //    NSLog(@"---After Array Shift---");
    //    [self printArray];
    
    beatsHappenedTimeStampedArray[9]=[NSDate date];
    
    //    NSLog(@"---Element 10 updated---");
    //    [self printArray];
    
    if (beatsSampleCounter > 9) {
        timeBetweenTenBeats = [beatsHappenedTimeStampedArray[9] timeIntervalSinceDate:beatsHappenedTimeStampedArray[0]];
        BPM = (60/timeBetweenTenBeats)*10;    //  (60/time of Last Ten Beats) x 10 = formual for BPM
        
        if (BPM > BPM+20 || BPM < BPM-20|| BPM > 160 || BPM < 54) {   //qualifies BPM for a grown-up
            [labelBPM setText:[NSString stringWithFormat:@"%i",BPM]];
            // [labelBPM setTextColor:[UIColor lightGrayColor]];
            // [labelHeart setText:@"--"];
            //           [labelHeart setTextColor:[UIColor lightGrayColor]];
        } else{
            
            //  [labelBPM setTextColor:[UIColor redColor]];
            [labelBPM setText:[NSString stringWithFormat:@"%i",BPM]];
        }
        
        lastBPM = BPM;
        
    } else if (beatsSampleCounter <= 9){
        [labelBPM setText:[NSString stringWithFormat:@"%i",beatsSampleCounter]];
        
    }
    
}

-(void) updateLabelsPulseSensorInterfaceElements{
    
    //  DEBUG
    //   NSLog(@"  Amp = %i,    Peak = %i,  Thresh = %i,  Signal = %i,  Trough = %i,  Pulse = %i  ", Amplitude, Peak,Threshold,Signal,Trough, Pulse);
    
    //    [labelAmplitude setText:[NSString stringWithFormat:@"Amp: %i",Amplitude]];
    //    [labelPeak setText:[NSString stringWithFormat:@"Peak: %i",Peak]];
    //    [labelThreshold setText:[NSString stringWithFormat:@"Thresh: %i",Threshold]];
    //    [labelTrough setText:[NSString stringWithFormat:@"Trough: %i",Trough]];
    //
    //    // Progress Bars Update
    //    [ progressBarAmp setProgress: Amplitude*0.001 ];
    //    [progressBarPeak setProgress: Peak*0.001];
    //    [progressBarThreshold setProgress:Threshold * 0.001];
    //    [progressBarTrough setProgress:Trough * 0.001];
    //}
    
    //-(void) printArray{
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@",beatsHappenedTimeStampedArray]);
}

-(void) resetAllPulseSensorVariables{
    
    Trough = 0;
    Threshold = 0;
    Peak = 0;
    Amplitude= 0;
}

-(void) resetPulseSensorAlgoVariables{
    
    Trough = 512;
    Peak = 512;
    Threshold = 512;
    Amplitude = 100;
    
}



/////////////////////////////////////
#pragma Arduino Pin Controle
/////////////////////////////////////

-(void) blinkLEDPin4ON{
    UInt8 buf[3] = {0x01, 0x00, 0x00};
    
    buf[1] = 0x01;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [readBearBLEinstance write:data];
}

-(void) blinkLEDPin4OFF{
    
    UInt8 buf[3] = {0x01, 0x00, 0x00};
    
    buf[1] = 0x00;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [readBearBLEinstance  write:data];
}




@end
