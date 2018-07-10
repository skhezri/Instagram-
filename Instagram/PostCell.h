//
//  PostCell.h
//  Instagram
//
//  Created by Sophia Khezri on 7/10/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "ParseUI.h"

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postedImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) Post * post;


-(void) setPost:(Post *)post;

@end
