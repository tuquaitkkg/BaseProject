//
//  RequestSuccess.m
//  BaseProject
//
//  Created by duc le trung on 1/17/17.
//  Copyright © 2017 3Si. All rights reserved.
//

#import "RequestSuccess.h"

@implementation RequestSuccess

- (id)init
{
    self = [super init];
    if (self) {
        _listData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithType:(RequestType)type{
    self = [self init];
    if(self){
        self.request_type = type;
    }
    return self;
}

@end
