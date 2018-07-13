//
//  LoginViewController.m
//  Instagram
//
//  Created by Sophia Khezri on 7/9/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController


- (IBAction)didTapSignUp:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            //[self alert:self.usernameTextField.text checkPassword:self.passwordTextField.text];
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}
- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self alert:username checkPassword:password];
            
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            //[self dismissViewControllerAnimated:YES completion:nil];
            // display view controller that needs to shown after successful login
        }
    }];
    
}

-(void)alert: (NSString *)user checkPassword:(NSString* )password{
    UIAlertController *alert;
    
    //assign alert variable and text based on the error
    if([self.usernameTextField.text isEqual:@""] || [self.passwordTextField.text isEqual:@""]){
        alert= [UIAlertController alertControllerWithTitle:@"Login Error" message:@"Password or Username is empty" preferredStyle:(UIAlertControllerStyleAlert)];
        
    } else{
        alert= [UIAlertController alertControllerWithTitle:@"Login Error" message:@"Password or Username is incorrect" preferredStyle:(UIAlertControllerStyleAlert)];
    }
    
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                             
    }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create gradient color for login page
    UIColor * top=[UIColor colorWithRed:123.0/255.0 green:104.0/255.0 blue:230.0/255.0 alpha:1.0];
     UIColor * bottom=[UIColor colorWithRed:196.0/255.0 green:85.0/255.0 blue:211.0/255.0 alpha:1.0];
    
    CAGradientLayer * gradient=[CAGradientLayer layer];
    gradient.colors=[NSArray arrayWithObjects:(id) top.CGColor, (id) bottom.CGColor, nil];
    gradient.frame=self.view.bounds;
    [self.view.layer insertSublayer:gradient atIndex:0];
    
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
