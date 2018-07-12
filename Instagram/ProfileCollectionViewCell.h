//
//  ProfileCollectionViewCell.h
//  Instagram
//
//  Created by Sophia Khezri on 7/11/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "ParseUI.h"

@interface ProfileCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *userPicture;
@property (strong, nonatomic) Post * post;

@end
