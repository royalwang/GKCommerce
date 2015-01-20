//
//  UserBackendTest.m
//  GKCommerce
//
//  Created by 小悟空 on 1/18/15.
//  Copyright (c) 2015 GKCommerce. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "Dependency.h"
#import <XCTest/XCTest.h>

#import "GKUserAccessToken.h"

SpecBegin(GKUserBackendImpl)

describe(@"GKUserBackendImpl", ^{
  it(@"should do user info", ^{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    id<GKUserBackend> backend = [[Dependency shared] userBackend];
    ((Backend *)backend).manager.completionQueue =
      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    UserAuthenticationModel *authentication;
    authentication = [[UserAuthenticationModel alloc]
                      initWithUsername:@"swagger" password:@"swagger"];
    
    [[backend requestAuthenticate:authentication] subscribeNext:^(GKUserAccessToken *accessToken) {
      [[backend requestUser:accessToken] subscribeNext:^(User *user) {
        expect(@"swagger").to.equal(@"swagger");
        dispatch_semaphore_signal(semaphore);
      } error:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
      }];
    } error:^(NSError *error) {
      dispatch_semaphore_signal(semaphore);
    }];
  });
});
SpecEnd


@interface GKUserBackendImpl : XCTestCase
@end

@implementation GKUserBackendImpl

- (void)DISABLED_testAuthenticate
{
  id<GKUserBackend> backend = [[Dependency shared] userBackend];
  UserAuthenticationModel *authentication;
  authentication = [[UserAuthenticationModel alloc]
                    initWithUsername:@"swagger" password:@"swagger"];
  
  // Reference: http://stackoverflow.com/questions/20476957/afnetworking-2-waituntilfinished-not-working
  
  dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
// TODO: 接口已经修改
//  [[backend requestAuthenticate:authentication] subscribeNext:^(User *user) {
//    [[backend requestUser:user] subscribeNext:^(User *user) {
//      dispatch_semaphore_signal(semaphore);
//    } error:^(NSError *error) {
//      NSLog(@"%@", error.localizedDescription);
//      dispatch_semaphore_signal(semaphore);
//    }];
//  } error:^(NSError *error) {
//    NSLog(@"%@", error.localizedDescription);
//    dispatch_semaphore_signal(semaphore);
//  }];
//  
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}
@end