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
- (void)getAPi:(NSDictionary*)parameters apiPath:(NSString*)apipath success:(successCallBack)success failureCallback:(failureCallBack)failure;
- (void)postApi:(NSDictionary*)parameters apiPath:(NSString*)apipath success:(successCallBack)success failureCallback:(failureCallBack)failure;
@property (nonatomic, weak) id<ASYammerDelegate> delegate;
@property (nonatomic, copy) NSString *appClientID;
@property (nonatomic, copy) NSString *appClientSecret;
@property (nonatomic, copy) NSString *authRedirectURI;
@end

//Delegates for Yammer Login
@protocol ASYammerDelegate
- (void)YammerLogin:(ASYammerModel *)loginClient didCompleteWithAuthToken:(NSString *)authToken;
- (void)YammerLogin:(ASYammerModel *)loginClient didFailWithError:(NSError *)error;
@end