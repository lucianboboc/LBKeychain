//
//  ViewController.m
//  LBkeychain-Demo
//
//  Created by Lucian Boboc on 8/19/13.
//  Copyright (c) 2013 Lucian Boboc. All rights reserved.
//

#import "ViewController.h"
#import "LBKeychain.h"


@interface ViewController ()
@property (strong,nonatomic) IBOutlet UITextField *username;
@property (strong,nonatomic) IBOutlet UITextField *password;

- (IBAction)saveAction:(id)sender;
- (IBAction)deleteAction:(id)sender;
@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [LBKeychain autocompleteValuesForUsernameField: self.username andPasswordField: self.password];
}

- (IBAction)saveAction:(id)sender
{
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    [LBKeychain saveUsernameValueInKeychain: username andPasswordValue: password];
    
    NSString *usr = [LBKeychain searchUsernameValueInKeychain];
    NSString *pass = [LBKeychain searchValueForIdentifierInKeychain: usr];
    
    NSLog(@"AFTER SAVE: username: %@, password: %@",usr, pass);
}



- (IBAction)deleteAction:(id)sender
{
    [LBKeychain deleteUsernameAndPasswordItemsFromKeychain];
    
    NSString *usr = [LBKeychain searchUsernameValueInKeychain];
    NSString *pass = [LBKeychain searchValueForIdentifierInKeychain: usr];
    
    NSLog(@"AFTER DELETE: username: %@, password: %@",usr, pass);
}

@end
