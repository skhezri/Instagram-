//
//  DetailsViewController.m
//  Instagram
//
//  Created by Sophia Khezri on 7/10/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "DetailsViewController.h"
#import "ParseUI.h"
#import "DateTools.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *instaPic;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameLabel.text=self.post.author.username;
    self.captionLabel.text=self.post.caption;
    self.instaPic.file= self.post[@"image"];
    self.likeButton.selected=self.post.liked;
    self.likeCountLabel.text=[self.post.likeCount stringValue];
    
    //Format createdAt date
    NSDate * createdAt= self.post.createdAt;
    NSDateFormatter * formatter= [[NSDateFormatter alloc] init];
    formatter.dateFormat= @"E MMM d HH:mm:ss Z y";
    //convert string to date
    //NSDate * date= [formatter dateFromString: createdAt];
    formatter.dateStyle= NSDateFormatterShortStyle;
    formatter.timeStyle= NSDateFormatterNoStyle;
    NSString * timeAgo= [NSDate shortTimeAgoSinceDate:createdAt];
    self.timestampLabel.text=timeAgo;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Takes user back to feed 
- (IBAction)didTapBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
