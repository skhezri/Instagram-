//
//  Post.h
//  Instagram
//
//  Created by Sophia Khezri on 7/10/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Post : PFObject <PFSubclassing>

//User properties
@property (nonatomic, strong) NSString * postID;
@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) PFUser * author;

//Photo properties
@property (nonatomic, strong) NSString * caption;
@property (nonatomic, strong) PFFile * image;
@property (nonatomic, strong) NSNumber * likeCount;
@property (nonatomic, strong) NSNumber * commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end
