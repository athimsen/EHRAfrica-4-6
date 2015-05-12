//
//  GeneralPatientViewController.m
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/11/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import "GeneralPatientViewController.h"
#import "Patient.h"
#import "General.h"
#import "AppDelegate.h"

@interface GeneralPatientViewController () <UITextFieldDelegate>

@property (nonatomic) NSInteger selectedFieldTag;

@end

@implementation GeneralPatientViewController

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)saveNewPatient {
    General* (^createNewGeneralInfo)() = ^()
    {        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM/dd/yyyy"];
        NSDate *date = [df dateFromString:_dateOfBirth.text];
        
        float timeStampDOB = (float)[date timeIntervalSince1970];
        
        General *generalInfo = [NSEntityDescription insertNewObjectForEntityForName:@"General" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
        [generalInfo setValue:_fullName.text forKey:@"name"];
        [generalInfo setValue:[NSNumber numberWithFloat:timeStampDOB] forKey:@"dob"];
        [generalInfo setValue:_gender.text forKey:@"gender"];
        [generalInfo setValue:[NSDecimalNumber decimalNumberWithString:_height.text] forKey:@"height"];
        [generalInfo setValue:[NSDecimalNumber decimalNumberWithString:_weight.text] forKey:@"weight"];
//        [generalInfo setValue:[NSNumber numberWithFloat:0.1f] forKey:@"idnumber"];

        return generalInfo;
    };
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Patient *newPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
    General *general = createNewGeneralInfo();
    
    [general setValue:newPatient forKey:@"patient"];
    
    [newPatient setValue:general forKey:@"general"];
    
    id globalStore = [[[appDelegate managedObjectContext] persistentStoreCoordinator] persistentStoreForURL:appDelegate.storeUrl];
    
    [[appDelegate managedObjectContext] assignObject:newPatient toPersistentStore:globalStore];
    
    [[appDelegate managedObjectContext] assignObject:general toPersistentStore:globalStore];
    
    [appDelegate.patientLookupById setObject:newPatient forKey:[general valueForKey:@"idnumber"]];
    NSString *name = [general valueForKey:@"name"];
    [appDelegate.patientLookupByName setObject:newPatient forKey:[name lowercaseString]];
    appDelegate.currentPatient = newPatient;
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient"
//                                              inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
//    [fetchRequest setEntity:entity];
//    
//    NSError *error;
//    NSArray *fetchedObjects = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluetooth.png"]];
    
    void (^setTextFieldDelegates)() = ^()
    {
        _fullName.delegate = self;
        _dateOfBirth.delegate = self;
        _gender.delegate = self;
        _height.delegate = self;
        _weight.delegate = self;
    };
    void (^addObservers)() = ^()
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(objectChanged)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
    };
    
    setTextFieldDelegates();
    addObservers();
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.translucent = YES;
    toolbar.tintColor = nil;
    [toolbar sizeToFit];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextSelected)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:@[spacer1,spacer,nextButton]];
    
    _fullName.inputAccessoryView = toolbar;
    _dateOfBirth.inputAccessoryView = toolbar;
    _gender.inputAccessoryView = toolbar;
    _height.inputAccessoryView = toolbar;
    
    UIToolbar *doneToolbar = [[UIToolbar alloc] init];
    doneToolbar.barStyle = UIBarStyleBlack;
    doneToolbar.translucent = YES;
    doneToolbar.tintColor = nil;
    [doneToolbar sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneSelected)];
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [doneToolbar setItems:@[spacer3,spacer2,doneButton]];
    
    _weight.inputAccessoryView = doneToolbar;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _selectedFieldTag = textField.tag;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 1) { //DOB field
        if (textField.text.length == 10 && ![string isEqualToString:@""]) {
            return NO;
        }
        NSString *newString = string;
        if ((textField.text.length + string.length == 2 || textField.text.length + string.length == 5)
            && ![string isEqualToString:@""]) {
            newString = [[NSString alloc] initWithFormat:@"%@/",string];
            textField.text = [textField.text stringByReplacingCharactersInRange:range withString:newString];
            return NO;
        }
    }
    return YES;
}

- (void)nextSelected {
    [[self.view viewWithTag:_selectedFieldTag+1] becomeFirstResponder];
}

- (void)doneSelected {
    [[self.view viewWithTag:_selectedFieldTag] resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    void (^removeObservers)() = ^()
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    };
    
    removeObservers();
    [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
}

- (void)objectChanged {
    return;
}


@end
