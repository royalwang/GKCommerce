//
//  ProductBackend.h
//  GKCommerce
//
//  Created by 小悟空 on 11/22/14.
//  Copyright (c) 2014 GKCommerce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Backend.h"
#import "ProductBackendDelegate.h"

@protocol ProductBackend <NSObject>

@required
@property (strong, nonatomic) id<ProductBackendDelegate> delegate;
- (void)requestProductWithID:(NSInteger)productID user:(User *)anUser;
@end