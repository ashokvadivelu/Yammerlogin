//
//  ASYammerModel.h
//  Yammersample
//
//  Created by Ashok on 16/10/15.
//  Copyright © 2015 Ashok. All rights reserved.
//

#import <Foundation/Foundation.h>
//Protocols
@protocol ASYammerDelegate;
//Block Callbacks
typedef void(^successCallBack)(id responseObject);
typedef void(^failureCallBack)(NSError *error);

@interface ASYammerModel : NSObject
+ (instancetype)sharedInstance;
- (void)YammerLogin;
- (void)YammerLogout;
- (NSString*)getYammerToken;
- (void)getYammerMessage:(NSDictionary*)parameters success:(successCallBack)success failureCallback:(failureCallBack)failure;
- (void)postYammerMessage:(NSDictionary*)parameters success:(successCallBack)success failureCallback:(failureCallBack)failure;
@property (nonatomic, weak) id<ASYammerDelegate> delegate;
@end

//Delegates for Yammer Login
@protocol ASYammerDelegate
- (void)YammerLogin:(ASYammerModel *)loginClient didCompleteWithAuthToken:(NSString *)authToken;
- (void)YammerLogin:(ASYammerModel *)loginClient didFailWithError:(NSError *)error;
@end