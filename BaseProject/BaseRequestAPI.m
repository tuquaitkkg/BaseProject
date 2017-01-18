//
//  BaseRequestAPI.m
//  BaseProject
//
//  Created by duc le trung on 1/13/17.
//  Copyright © 2017 3Si. All rights reserved.
//

#import "BaseRequestAPI.h"

@implementation BaseRequestAPI

+ (BaseRequestAPI *)sharedInstance {
    static dispatch_once_t onceToken;
    static BaseRequestAPI *sharedInstance = nil;
    // make sure it run only one
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[BaseRequestAPI alloc] init];
        }
    });
    return sharedInstance;
}

- (AFHTTPSessionManager *)createHTTPRequestManager {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = kTimeOut;
    
    return manager;
}

- (void) getDefaultNotification: (NSString*) deviceID withAppID: (NSString*) appID delegate:(NSObject<ManagerDownloadDelegate>*) delegate andViewController:(UIViewController *)viewVC{
    
    NSString *strRequest = @"";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    RequestSuccess *request = [[RequestSuccess alloc] initWithType:RequestType_GET_DEFAULT_NOTIFICATION];
    request.delegate = delegate;
    
    [self postRequestWithURLString:strRequest andParameters:params andRequestSuccess:request withViewController:viewVC];
}

- (void)postRequestWithURLString:(NSString *)urlString andParameters:(NSMutableDictionary *)params andRequestSuccess:(RequestSuccess *)requestSuccess withViewController:(UIViewController *)viewVC {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        AFHTTPSessionManager *manager = [self createHTTPRequestManager];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *urlResponde = (NSHTTPURLResponse *)task.response;
            NSDictionary *dictHeader = [urlResponde allHeaderFields];
            
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:NULL];
            
            requestSuccess.dictHeader = dictHeader;
            requestSuccess.listData = [self processData:jsonResponse with:requestSuccess];
            
            if([requestSuccess.delegate respondsToSelector:@selector(downloadDataSuccess:)]) {
                [requestSuccess.delegate downloadDataSuccess:requestSuccess];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *urlResponde = (NSHTTPURLResponse *)task.response;
             requestSuccess.status_code = urlResponde.statusCode;
            
            NSData *dataError = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (dataError) {
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:dataError
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:NULL];
                requestSuccess.dictError = jsonResponse;
            }
            [[RequestFailure sharedInstance] errorRequestFromParameter:requestSuccess];
            if([requestSuccess.delegate respondsToSelector:@selector(downloadDataFail:)]) {
                [requestSuccess.delegate downloadDataSuccess:requestSuccess];
            }
        }];
    });
}

- (void)getRequestWithURLString:(NSString *)urlString andParameters:(NSMutableDictionary *)params andRequestSuccess:(RequestSuccess *)requestSuccess withViewController:(UIViewController *)viewVC {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        AFHTTPSessionManager *manager = [self createHTTPRequestManager];
        
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *urlResponde = (NSHTTPURLResponse *)task.response;
            NSDictionary *dictHeader = [urlResponde allHeaderFields];
            
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:NULL];
            
            requestSuccess.dictHeader = dictHeader;
            requestSuccess.listData = [self processData:jsonResponse with:requestSuccess];
            
            if([requestSuccess.delegate respondsToSelector:@selector(downloadDataSuccess:)]) {
                [requestSuccess.delegate downloadDataSuccess:requestSuccess];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *urlResponde = (NSHTTPURLResponse *)task.response;
            requestSuccess.status_code = urlResponde.statusCode;
            
            NSData *dataError = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (dataError) {
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:dataError
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:NULL];
                requestSuccess.dictError = jsonResponse;
            }
            [[RequestFailure sharedInstance] errorRequestFromParameter:requestSuccess];
            if([requestSuccess.delegate respondsToSelector:@selector(downloadDataFail:)]) {
                [requestSuccess.delegate downloadDataSuccess:requestSuccess];
            }
            
        }];
    });
}

- (NSMutableArray *)processData:(NSDictionary *)dictJSON with:(RequestSuccess *)requestSuccess {
    NSMutableArray *arrayData = [[NSMutableArray alloc] init];
    return arrayData;
}




@end
