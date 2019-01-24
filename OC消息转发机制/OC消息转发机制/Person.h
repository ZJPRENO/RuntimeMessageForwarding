//
//  Person.h
//  OC消息转发机制
//
//  Created by 张俊平 on 2018/12/29.
//  Copyright © 2018 ZHANGJUNPING. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

#pragma mark - 发送消息
- (void)sendMessage:(NSString*)message;

@end

NS_ASSUME_NONNULL_END
