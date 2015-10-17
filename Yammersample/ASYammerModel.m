//
//  ASYammerModel.m
//  Yammersample
//
//  Created by Ashok on 16/10/15.
//  Copyright © 2015 Ashok. All rights reserved.
//

#import "ASYammerModel.h"
#import <YammerSDK/YMLoginClient.h>
#import <YammerSDK/YMAPIClient.h>
NSString * const ASMessageApiString = @"/api/v1/messages.json";
@interface ASYammerModel ()<YMLoginClientDelegate>
@end
@implementation ASYammerModel
+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
#pragma mark- Public Methods
//call this method to get login in yammer
-(void)YammerLogin
{
    [YMLoginClient sharedInstance].delegate = self;
    [[YMLoginClient sharedInstance] startLogin];
}
//Clear the auth token to get logout in yammer
- (void)YammerLogout
{
    [[YMLoginClient sharedInstance] clearAuthTokens];
}
#pragma mark-Token
- (NSString*)getYammerToken
{
    return [[YMLoginClient sharedInstance] storedAuthToken];
}
#pragma mark- Yammer Blocks Post/Get messages from Yammer
//Get the message from the yammer using Yammer auth token and get the response in callback and send success/failure response
- (void)getYammerMessage:(NSDictionary*)parameters success:(successCallBack)success failureCallback:(failureCallBack)failure
{
    YMAPIClient *client = [[YMAPIClient alloc] initWithAuthToken:[self getYammerToken]];
    // the postPath is where the path is appended to the baseUrl
    // the params are the query params
    [client getPath:ASMessageApiString
         parameters:parameters
            success:^(id responseObject) {
                success(responseObject);
                
            }
            failure:^(NSError *error) {
                failure(error);
                
                
            }
     ];
}
//Post the message to the yammer using Yammer auth token and get the response in callback and send success/failure response
- (void)postYammerMessage:(NSDictionary*)parameters success:(successCallBack)success failureCallback:(failureCallBack)failure
{
    YMAPIClient *client = [[YMAPIClient alloc] initWithAuthToken:[self getYammerToken]];
    [client postPath:ASMessageApiString
          parameters:parameters
             success:^(id responseObject) {
                  success(responseObject);
             }
             failure:^(NSInteger statusCode,NSError *errorr) {
                 failure(errorr);
                 
             }
     ];
}
#pragma mark - Yammer Login controller delegate methods

- (void)loginClient:(YMLoginClient *)loginClient didCompleteWithAuthToken:(NSString *)authToken
{
    // call the delgate to tell logged in is success.
    [_delegate YammerLogin:self didCompleteWithAuthToken:authToken];
}
- (void)loginClient:(YMLoginClient *)loginClient didFailWithError:(NSError *)error
{
    //Call back for the yammer failure.
    [_delegate YammerLogin:self didFailWithError:error];
}
@end
