//
//  MyRequest.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/8.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "MyRequest.h"

@implementation MyRequest

+ (AFHTTPSessionManager *)sharedRequestManager{
        static AFHTTPSessionManager *sharedInstance = nil;
        if (!sharedInstance) {
            //创建一个HTTP请求操作管理器对象
            sharedInstance = [AFHTTPSessionManager manager];
            //AFNetworking 默认只支持application/json类型的响应
            //有一些服务器返回的可能不是JSON格式类型
            //通过下面代码可以支持其他类型
            //
            sharedInstance.responseSerializer = [AFJSONResponseSerializer serializer];
            sharedInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/xml",nil];
        }
        return sharedInstance;

}



+ (void)getDataByAddress:(NSString *)addressName parmas:(id)parmas requestSucess:(void (^)(id))successBlock failer:(void (^)(id))failBlock{
     AFHTTPSessionManager *requestManager = [self sharedRequestManager];
   
    [requestManager GET:addressName parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock([error localizedDescription]);
        }
    }];
}
@end
