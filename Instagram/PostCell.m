//
//  PostCell.m
//  Instagram
//
//  Created by Sophia Khezri on 7/10/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "PostCell.h"


@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setPost:(Post *)post{
    _post=post;
    self.usernameLabel.text=post.author.username;
    self.captionLabel.text=post.caption;
    self.postedImage.file= post[@"image"];
    [self.postedImage loadInBackground];
    
}

@end
