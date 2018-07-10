//
//  FeedViewController.m
//  Instagram
//
//  Created by Sophia Khezri on 7/9/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "FeedViewController.h"
#import "Parse.h"
#import "LoginViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
         [self performSegueWithIdentifier:@"logoutSegue" sender:nil];
    }];
    
}
- (IBAction)didTapCameraButton:(id)sender {
    [self performSegueWithIdentifier:@"composePhotoSegue" sender:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
