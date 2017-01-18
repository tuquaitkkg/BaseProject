//
//  RequestFailure.m
//  BaseProject
//
//  Created by duc le trung on 1/17/17.
//  Copyright © 2017 3Si. All rights reserved.
//

#import "RequestFailure.h"

@implementation RequestFailure

+ (RequestFailure *)sharedInstance{
    static RequestFailure *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[RequestFailure alloc] init];
        }
    });
    return sharedInstance;
}

- (void)errorRequestFromParameter:(RequestSuccess *)param{
    switch (param.status_code) {
        case ERROR_HTTP_DONT_NETWORK:
            
            break;
        case ERROR_BAD_REQUEST:{
            
            break;
        }
        case ERROR_TOO_MANY_REQUEST:
            
            break;
        case ERROR_INTERNAL_SERVER:
            
            break;
        case ERROR_BAD_GATE_WAY:
            
            break;
        case ERROR_SERVICE_UNAVAILABLE:
            
            break;
        case ERROR_GATEWAY_TIMEOUT:
            
            break;
        case ERROR_FORBIDDEN:{
            
            break;
        } case ERROR_NOT_FOUND:{
            
            break;
        }
        default:
            break;
    }
}

@end
