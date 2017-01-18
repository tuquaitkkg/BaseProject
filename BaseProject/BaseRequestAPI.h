//
//  BaseRequestAPI.h
//  BaseProject
//
//  Created by duc le trung on 1/13/17.
//  Copyright © 2017 3Si. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "RequestSuccess.h"
#import "RequestFailure.h"

#define kTimeOut 30

@interface BaseRequestAPI : NSObject

+ (BaseRequestAPI *)sharedInstance;


@end
