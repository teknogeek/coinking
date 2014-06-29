//
//  SettingsViewController.m
//  coinking
//
//  Created by CG3 on 6/29/14.
//  Copyright (c) 2014 CoinKing.io. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
{
    NSString *apiKeyString;
}
@end

@implementation SettingsViewController

@synthesize apiKey;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    apiKeyString = [defaults objectForKey:@"apiKey"];
    
    // Update the UI elements with the saved dat
    [apiKey setDelegate:self];
    apiKey.text = apiKeyString;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [apiKey resignFirstResponder];
    [self saveAPIKey];
    return YES;
}

-(void)saveAPIKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *storedVal = apiKey.text;
    NSString *key = @"apiKey"; // the key for the data
    
    [defaults setObject:storedVal forKey:key];
    [defaults synchronize]; // this method is optional
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
