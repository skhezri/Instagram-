//
//  Post.m
//  Instagram
//
//  Created by Sophia Khezri on 7/10/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "Post.h"
#import "ComposePhotoViewController.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic liked;

+(nonnull NSString *) parseClassName{
    return @"Post";

}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Post * newPost=[Post new];
    newPost.image=[self getPFFileFromImage: image];
    newPost.author=[PFUser currentUser];
    newPost.caption=caption;
    newPost.likeCount=@(0);
    newPost.commentCount=@(0);
    [newPost saveInBackgroundWithBlock: completion];
    
}

+(PFFile *) getPFFileFromImage: (UIImage * _Nullable) image{
    //check if the image is not nil
    if(!image){
        return nil;
    }
    NSData * imageData =UIImagePNGRepresentation(image);
    if(!imageData){
        return nil;
    }
    
    return [PFFile fileWithName: @"image.png" data:imageData];
    
}














@end
