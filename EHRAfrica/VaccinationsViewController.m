//
//  VaccinationsViewController.m
//  EHRAfrica
//
//  Created by Admin on 4/26/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import "VaccinationsViewController.h"
#import "Patient.h"
#import "Vaccinations.h"
#import "AppDelegate.h"

@interface VaccinationsViewController () <UITextFieldDelegate>
@property (nonatomic) NSInteger selectedFieldTag;

@end

@implementation VaccinationsViewController

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)saveNewPatient {
    Vaccinations* (^createNewVaccinationsInfo)() = ^()
    {
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM/dd/yyyy"];
        NSDate *varcelladate = [df dateFromString:_varcelladate.text];
        NSDate *hepatitisadate = [df dateFromString:_hepatitisadate.text];
        NSDate *hepatitisbdate = [df dateFromString:_hepatitisbdate.text];
        NSDate *meningitisdate = [df dateFromString:_meningitisdate.text];
        NSDate *yellowfdate = [df dateFromString:_yellowfdate.text];
        NSDate *typhoidfdate = [df dateFromString:_typhoidfdate.text];
        NSDate *poliodate = [df dateFromString:_poliodate.text];
        NSDate *rabiesdate = [df dateFromString:_rabiesdate.text];
        NSDate *rotavirusdate = [df dateFromString:_rotavirusdate.text];
        NSDate *mmrdate = [df dateFromString:_mmrdate.text];
        
        float timeStampvarcelladate = (float)[varcelladate timeIntervalSince1970];
        float timeStamphepatitisadate = (float)[hepatitisadate timeIntervalSince1970];
        float timeStamphepatitisbdate = (float)[hepatitisbdate timeIntervalSince1970];
        float timeStampmeningitisdate = (float)[meningitisdate timeIntervalSince1970];
        float timeStampyellowfdate = (float)[yellowfdate timeIntervalSince1970];
        float timeStamptyphoidfdate = (float)[typhoidfdate timeIntervalSince1970];
        float timeStamppoliodate = (float)[poliodate timeIntervalSince1970];
        float timeStamprabiesdate = (float)[rabiesdate timeIntervalSince1970];
        float timeStamprotavirusdate = (float)[rotavirusdate timeIntervalSince1970];
        float timeStampmmrdate = (float)[mmrdate timeIntervalSince1970];
       
        
        Vaccinations *vaccinationsInfo = [NSEntityDescription insertNewObjectForEntityForName:@"Vaccinations" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
        
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStampvarcelladate] forKey:@"varcelladate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStamphepatitisbdate] forKey:@"hepatitisbdate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStamphepatitisadate] forKey:@"hepatitisbdate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStampmeningitisdate] forKey:@"meningitisdate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStampyellowfdate] forKey:@"yellowfdate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStamptyphoidfdate] forKey:@"typhoidfdate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStamppoliodate] forKey:@"poliodate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStamprabiesdate] forKey:@"rabiesdate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStamprotavirusdate] forKey:@"rotavirusdate"];
        [vaccinationsInfo setValue:[NSNumber numberWithFloat:timeStampmmrdate] forKey:@"mmrdate"];
        
        
        return vaccinationsInfo;
    };
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Patient *newPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
    Vaccinations *vaccinations = createNewVaccinationsInfo();
    
    [vaccinations setValue:newPatient forKey:@"patient"];
    
    [newPatient setValue:vaccinations forKey:@"vaccinations"];
    
    id globalStore = [[[appDelegate managedObjectContext] persistentStoreCoordinator] persistentStoreForURL:appDelegate.storeUrl];
    
    [[appDelegate managedObjectContext] assignObject:newPatient toPersistentStore:globalStore];
    
    [[appDelegate managedObjectContext] assignObject:vaccinations toPersistentStore:globalStore];
    
    [appDelegate.patientLookupById setObject:newPatient forKey:[vaccinations valueForKey:@"idnumber"]];
    NSString *name = [vaccinations valueForKey:@"name"];
    [appDelegate.patientLookupByName setObject:newPatient forKey:[name lowercaseString]];
    appDelegate.currentPatient = newPatient;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluetooth.png"]];
    
    void (^setTextFieldDelegates)() = ^()

    {
        _varcelladate.delegate = self;
        _hepatitisadate.delegate = self;
        _hepatitisbdate.delegate = self;
        _meningitisdate.delegate = self;
        _yellowfdate.delegate = self;
        _typhoidfdate.delegate = self;
        _poliodate.delegate = self;
        _rabiesdate.delegate = self;
        _rotavirusdate.delegate = self;
        _mmrdate.delegate = self;
        
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
    
    _varcelladate.inputAccessoryView = toolbar;
    _hepatitisadate.inputAccessoryView = toolbar;
    _hepatitisbdate.inputAccessoryView = toolbar;
    _meningitisdate.inputAccessoryView = toolbar;
    _yellowfdate.inputAccessoryView = toolbar;
    _typhoidfdate.inputAccessoryView = toolbar;
    _poliodate.inputAccessoryView = toolbar;
    _rotavirusdate.inputAccessoryView = toolbar;
    _mmrdate.inputAccessoryView = toolbar;
    
    UIToolbar *doneToolbar = [[UIToolbar alloc] init];
    doneToolbar.barStyle = UIBarStyleBlack;
    doneToolbar.translucent = YES;
    doneToolbar.tintColor = nil;
    [doneToolbar sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneSelected)];
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [doneToolbar setItems:@[spacer3,spacer2,doneButton]];
    
    _varcelladate.inputAccessoryView = doneToolbar;
    // Do any additional setup after loading the view, typically from a nib.
}
    
    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (appDelegate.currentPatient == nil) {
//        _patientProfile.hidden = YES;
//    } else {
//        _patientProfile.hidden = NO;
//    }
    // Do any additional setup after loading the view, typically from a nib.
//}

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
