//
//  RequestSuccess.h
//  BaseProject
//
//  Created by duc le trung on 1/17/17.
//  Copyright © 2017 3Si. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestType) {
    RequestType_GET_DEFAULT_NOTIFICATION
};

@protocol ManagerDownloadDelegate;

@interface RequestSuccess : NSObject

@property (nonatomic) NSInteger status_code;
@property (nonatomic) NSInteger apple_error_code;
@property (nonatomic, strong) NSString *msgError;

@property (nonatomic, strong) NSDictionary *dictHeader;
@property (nonatomic, strong) NSDictionary *dictError;
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic) RequestType request_type;

@property (nonatomic, assign) NSObject<ManagerDownloadDelegate> *delegate;

- (id)initWithType:(RequestType)type;

@end

@protocol ManagerDownloadDelegate <NSObject>
@optional
- (void)downloadDataSuccess:(RequestSuccess *)param;
- (void)downloadDataFail:(RequestSuccess *)param;
@end
