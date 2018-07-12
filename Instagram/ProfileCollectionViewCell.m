//
//  ProfileCollectionViewCell.m
//  Instagram
//
//  Created by Sophia Khezri on 7/11/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "ProfileCollectionViewCell.h"

@implementation ProfileCollectionViewCell



-(void)setPost:(Post *)post{
    _post=post;
    self.userPicture.file= post[@"image"];
    [self.userPicture loadInBackground];
}

@end
