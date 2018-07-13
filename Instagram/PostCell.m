//
//  PostCell.m
//  Instagram
//
//  Created by Sophia Khezri on 7/10/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "PostCell.h"
#import "DateTools.h"
#import "ProfileCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"


@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapLikeButton:(id)sender {
    if(self.post.liked==NO){
        self.post.liked=YES;
        NSInteger likeInteger=[self.post.likeCount integerValue];
        likeInteger+=1;
        NSNumber * likeNumValue=[NSNumber numberWithInteger:likeInteger];
        self.post.likeCount=likeNumValue;
        self.likeButton.selected=YES;
        self.likeCountLabel.text=[likeNumValue stringValue];
    } else{
       self.post.liked=NO;
       self.likeButton.selected=NO;
        NSInteger likeInteger=[self.post.likeCount integerValue];
        likeInteger-=1;
        NSNumber * likeNumValue=[NSNumber numberWithInteger:likeInteger];
        self.post.likeCount=likeNumValue;
        self.likeButton.selected=NO;
        self.likeCountLabel.text=[likeNumValue stringValue];
  }
}
-(void)setPost:(Post *)post{
    _post=post;
    self.usernameLabel.text=post.author.username;
    self.captionLabel.text=post.caption;
    self.postedImage.image = nil;
    self.postedImage.file= post[@"image"];
    PFUser * user = PFUser.currentUser;
    if ([post.author[@"profilePic"] isEqual:user[@"profilePic"]]){
        self.profilePicture.file = user[@"profilePic"];
        [self.profilePicture loadInBackground];
    }
    [self.postedImage loadInBackground:^(UIImage * _Nullable image, NSError * _Nullable error) {
        [self.postedImage layoutIfNeeded];
    }];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
    //Format createdAt date
    NSDate * createdAt= self.post.createdAt;
    NSDateFormatter * formatter= [[NSDateFormatter alloc] init];
    formatter.dateFormat= @"E MMM d HH:mm:ss Z y";
    //convert string to date
    //NSDate * date= [formatter dateFromString: createdAt];
    formatter.dateStyle= NSDateFormatterShortStyle;
    formatter.timeStyle= NSDateFormatterNoStyle;
    NSString * timeAgo= [NSDate shortTimeAgoSinceDate:createdAt];
    self.timeStampLabel.text=timeAgo;
}

@end
