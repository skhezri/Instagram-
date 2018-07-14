//
//  FeedViewController.m
//  Instagram
//
//  Created by Sophia Khezri on 7/9/18.
//  Copyright © 2018 Sophia Khezri. All rights reserved.
//

#import "FeedViewController.h"
#import "Parse.h"
#import "LoginViewController.h"
#import "FeedViewController.h"
#import "PostCell.h"
#import "Post.h"
#import "DetailsViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * postArr;

@end

@implementation FeedViewController

//Action for the logout button
- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [self performSegueWithIdentifier:@"logoutSegue" sender:nil];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.postArr=[[NSArray alloc]init];
    [self fetchUserPosts];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    //self.tableView.rowHeight = 514;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation

//segues to the details view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"detailsSegue"]){
        UITableViewCell * tappedCell =sender;
        NSIndexPath *indexPath= [self.tableView indexPathForCell:tappedCell];
        Post* singlePost= self.postArr[indexPath.row];
        DetailsViewController * detailsViewController=[segue destinationViewController];
        detailsViewController.post=singlePost;
    }
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell= [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post * post=self.postArr[indexPath.row];
    cell.post=post;
    [cell setPost:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArr.count;
}

//Retrieves all of the posts from Parse
-(void)fetchUserPosts{
    PFQuery * query=[PFQuery queryWithClassName:@"Post"];
    query.limit=20;
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"image"];
    [query includeKey: @"author"];
    [query includeKey: @"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * instaPosts, NSError * error){
        if(instaPosts!=nil){
            self.postArr=instaPosts;
            [self.tableView reloadData];
        } else{
            NSLog(@"%@", error.localizedDescription);
            
        }
        
    }];
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    //fetch the new posts
    [self fetchUserPosts];
    //tell refreshControl to stop spinning
    [refreshControl endRefreshing];
}


@end
