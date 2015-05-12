//
//  PersonalHxViewController.m
//  EHRAfrica
//
//  Created by Admin on 4/26/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import "PersonalHxViewController.h"
#import "AppDelegate.h"
#import "Patient.h"
#import "PersonalHx.h"

@interface PersonalHxViewController () <UITextFieldDelegate>

@property (nonatomic) NSInteger selectedFieldTag;

@end

@implementation PersonalHxViewController

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)saveNewPatient {
    PersonalHx* (^createNewPersonalHxInfo)() = ^()
    
    {
        PersonalHx *personalhxInfo = [NSEntityDescription insertNewObjectForEntityForName:@"PersonalHx" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
        [personalhxInfo setValue:_medhx.text forKey:@"medhx"];
        [personalhxInfo setValue:_famhx.text forKey:@"famhx"];
        [personalhxInfo setValue:_allergies.text forKey:@"allergies"];
        [personalhxInfo setValue:_sochx.text forKey:@"sochx"];
        
        
        return personalhxInfo;
    };
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Patient *newPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
    PersonalHx *personalhx = createNewPersonalHxInfo();
    
    [personalhx setValue:newPatient forKey:@"patient"];
    
    [newPatient setValue:personalhx forKey:@"personalhx"];
    
    id globalStore = [[[appDelegate managedObjectContext] persistentStoreCoordinator] persistentStoreForURL:appDelegate.storeUrl];
    
    [[appDelegate managedObjectContext] assignObject:newPatient toPersistentStore:globalStore];
    
    [[appDelegate managedObjectContext] assignObject:personalhx toPersistentStore:globalStore];
    
    [appDelegate.patientLookupById setObject:newPatient forKey:[personalhx valueForKey:@"idnumber"]];
    NSString *name = [personalhx valueForKey:@"name"];
    [appDelegate.patientLookupByName setObject:newPatient forKey:[name lowercaseString]];
    appDelegate.currentPatient = newPatient;
    
    
    //Patient *newPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]];
//    PersonalHx *personalhx = createNewPersonalHxInfo();
//    
//    [personalhx setValue:newPatient forKey:@"patient"];
//    
//    [newPatient setValue:personalhx forKey:@"personalhx"];
    
    //    General *fetchedGeneral = (General *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] objectWithID:(NSManagedObjectID*)@"9A73EA4A-2C7D-4A36-B5A7-1C0A1E49EA433"];
    
    
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
        _medhx.delegate = self;
        _famhx.delegate = self;
        _allergies.delegate = self;
        _sochx.delegate = self;
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
    // Do any additional setup after loading the view, typically from a nib.
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.translucent = YES;
    toolbar.tintColor = nil;
    [toolbar sizeToFit];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextSelected)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:@[spacer1,spacer,nextButton]];
    
    _medhx.inputAccessoryView = toolbar;
    _famhx.inputAccessoryView = toolbar;
    _allergies.inputAccessoryView = toolbar;
    _sochx.inputAccessoryView = toolbar;
    
    UIToolbar *doneToolbar = [[UIToolbar alloc] init];
    doneToolbar.barStyle = UIBarStyleBlack;
    doneToolbar.translucent = YES;
    doneToolbar.tintColor = nil;
    [doneToolbar sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneSelected)];
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [doneToolbar setItems:@[spacer3,spacer2,doneButton]];
    
    _allergies.inputAccessoryView = doneToolbar;
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

