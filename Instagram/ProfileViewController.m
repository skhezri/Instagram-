//
//  ProfileViewController.m
//  Instagram
//
//  Created by Sophia Khezri on 7/10/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse.h"
#import "ProfileCollectionViewCell.h"
#import "Post.h"
#import "ParseUI.h"
#import "DetailsViewController.h"
@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numOfPostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray * userPicsArray;
@property (strong, nonatomic) Post * post;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self fetchUserPosts];
    self.editProfileButton.layer.borderWidth=0.5f;
    self.usernameLabel.text=self.post.author.username;
    //Create a circle for profile picture
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    self.profilePic.clipsToBounds = YES;
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout= (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing=2;
    layout.minimumLineSpacing=2;
    CGFloat posterPerLine=3;
    CGFloat itemWidth=(self.collectionView.frame.size.width-layout.minimumInteritemSpacing * (posterPerLine-1))/posterPerLine;
    //CGFloat itemHeight=itemWidth;//random ratio chosen
    CGFloat itemHeight=itemWidth;
    layout.itemSize=CGSizeMake(itemWidth, itemHeight);
    PFUser * user = PFUser.currentUser;
    self.profilePic.file = user[@"profilePic"];
    self.usernameLabel.text=user.username;
    [self.profilePic loadInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"profileToDetailsSegue"]){
        UICollectionViewCell * tappedCell =sender;
        NSIndexPath *indexPath= [self.collectionView indexPathForCell:tappedCell];
        Post* singlePost= self.userPicsArray[indexPath.row];
        DetailsViewController * detailsViewController=[segue destinationViewController];
        detailsViewController.post=singlePost;
    }
}
-(void)fetchUserPosts{
    PFQuery * query=[PFQuery queryWithClassName:@"Post"];
    query.limit=20;
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"image"];
    [query includeKey: @"author"];

    [query findObjectsInBackgroundWithBlock:^(NSArray * instaPosts, NSError * error){
        if(instaPosts!=nil){
            self.userPicsArray=instaPosts;
            [self.collectionView reloadData];
        } else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionViewCell" forIndexPath:indexPath];
    Post * post=self.userPicsArray[indexPath.row];
    cell.post=post;
    [cell setPost:post];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPicsArray.count;
}
- (IBAction)didTapChangeProfPicButton:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

-(PFFile *) getPFFileFromImage: (UIImage * _Nullable) image{
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // Get the image captured by the UIImagePickerController
    //UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    //editedImage=[self resizeImage:editedImage withSize:CGSizeMake(350, 350)];
    [self.profilePic setImage:editedImage];
    PFUser *user= PFUser.currentUser;
    user[@"profilePic"]=[self getPFFileFromImage:editedImage];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(!succeeded){
            NSLog(@"%@", error.localizedDescription);
        }
       
    }];
}

@end
