//
//  ViewController.m
//  Yammersample
//
//  Created by Ashok on 06/10/15.
//  Copyright (c) 2015 Ashok. All rights reserved.
//

#import "ViewController.h"

#import "ASYammerModel.h"
@interface ViewController ()<ASYammerDelegate>
{
    IBOutlet UIButton *loginButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
#pragma mark-Custom Actions

- (IBAction)login:(id)sender
{
    [[ASYammerModel sharedInstance]YammerLogin];
}
#pragma mark-Custom Action Post/Get Message
//Trigger this method to post message to yammer api.
- (IBAction)attemptYammerApiCall:(id)sender
{
    // Check the authToken is  exists
    if([[ASYammerModel sharedInstance] getYammerToken]) {
        [self postMessage];
    }else {
        [[ASYammerModel sharedInstance]YammerLogin];
    }
}
- (IBAction)getYammerApiCall:(id)sender
{
    [self getYammerMessage];
}
#pragma mark-Private method
//call this method to get message from yammer
- (void)getYammerMessage
{
    //Check token is exists
    if([[ASYammerModel sharedInstance] getYammerToken]){
        
        // Query params (in this case there are no params, but if there were, this is how you'd add them)
        NSDictionary *params = @{ @"threaded": @"extended", @"limit": @30 };
        
        [[ASYammerModel sharedInstance]getYammerMessage:params success:^(id responseObject) {
            
            NSLog(@"Message-%@",responseObject);
            
        } failureCallback:^(NSError *error) {
            
            NSLog(@"error: %@", error);
        }
         ];
    
    }else{
        
        NSLog(@"Not logged in Yammer");
        //call this method to get login in yammer
        [[ASYammerModel sharedInstance]YammerLogin];
    }
}

//call this method to post message to yammer
- (void)postMessage
{
    // Query params (in this case there are no params, but if there were, this is how you'd add them)
    NSDictionary *params = @{ @"body": @"REPLACE_REPLY_MESSAGE_HERE",@"replied_to_id":@"REPLACE_YAMMER_REPLY_ID_HERE"};
    [[ASYammerModel sharedInstance]postYammerMessage:params success:^(id responseObject) {
        
        NSLog(@"Message-%@",responseObject);
        
    } failureCallback:^(NSError *error) {
        
        NSLog(@"error: %@", error);
    }
     ];
    
}
//call this method to logout from the yammer.
- (void)logout
{
    [[ASYammerModel sharedInstance] YammerLogout];
}

#pragma mark - Yammer Login delegate methods
//This delegate will trigger after get login in yammer
- (void)YammerLogin:(ASYammerModel *)loginClient didCompleteWithAuthToken:(NSString *)authToken
{
    NSLog(@"Logged in Yammer Successfully");
}
//This delegate will trigger when there is error in yammer login
- (void)YammerLogin:(ASYammerModel *)loginClient didFailWithError:(NSError *)error
{
    NSLog(@"Failure in Yammer login");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
