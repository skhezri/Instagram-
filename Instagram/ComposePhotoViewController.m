//
//  ComposePhotoViewController.m
//  Instagram
//
//  Created by Sophia Khezri on 7/9/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "ComposePhotoViewController.h"
#import "Post.h"

@interface ComposePhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *chosenImage;
@property (weak, nonatomic) IBOutlet UITextField *imageCaptionText;
@property (weak, nonatomic) NSString * captionText;
@end

@implementation ComposePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}
- (IBAction)didTapCancelButton:(id)sender {
     [self performSegueWithIdentifier:@"cancelComposeSegue" sender:nil];
}
- (IBAction)didTapShareButton:(id)sender {
    self.captionText=self.imageCaptionText.text;
    [Post postUserImage:self.chosenImage.image withCaption:self.captionText withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"Shared Successfully");
        } else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    [self performSegueWithIdentifier:@"shareSegue" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    //UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    editedImage=[self resizeImage:editedImage withSize:CGSizeMake(350, 350)];
    [self.chosenImage setImage:editedImage];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
