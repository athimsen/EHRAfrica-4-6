//
//  ViewController2.m
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/13/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import "HomeViewController.h"
#import "GeneralPatientViewController.h"

@interface PresentNewPatientSegue : UIStoryboardSegue

@end

@implementation PresentNewPatientSegue

- (void)perform {
    HomeViewController *sourceViewController = self.sourceViewController;
    GeneralPatientViewController *generalPatientVC = [[GeneralPatientViewController alloc] init];
    [sourceViewController.navigationController presentViewController:generalPatientVC animated:YES completion:nil];
}

@end


@interface HomeViewController ()

@end

@implementation HomeViewController

- (IBAction)unwindToRoot:(UIStoryboardSegue*)sender
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluetooth.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
