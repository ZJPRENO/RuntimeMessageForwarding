//
//  Person.m
//  OC消息转发机制
//
//  Created by 张俊平 on 2018/12/29.
//  Copyright © 2018 ZHANGJUNPING. All rights reserved.
//

#import "Person.h"
#import "SpareWheel.h" //作为消息转发的备用者
#import <objc/runtime.h>

@implementation Person

#pragma mark - 消息转发方法

void sendMessage(id self,SEL _cmd,NSString* message) {
	NSLog(@"---%@",message);
}

//第一步：对象在收到无法解读的消息后，首先会调用+(BOOL)resolveInstanceMethod:(SEL)sel
//或者+ (BOOL)resolveClassMethod:(SEL)sel, 询问是否有动态添加方法来进行处理，处理实例如下
+(BOOL)resolveInstanceMethod:(SEL)sel {
	// 方法匹配
	NSString *methodName = NSStringFromSelector(sel);
//	if ([methodName isEqualToString:@"sendMessage:"]) {
//		return class_addMethod(self, sel, (IMP)sendMessage, "v@:@");
//	}
	return [super resolveInstanceMethod:sel];
}

#pragma mark - 快速转发  找一个备用者
-(id)forwardingTargetForSelector:(SEL)aSelector {

	NSString *methodName = NSStringFromSelector(aSelector);
			if ([methodName isEqualToString:@"sendMessage:"]) {
		return [SpareWheel new];
	}
	return [super forwardingTargetForSelector:aSelector];
}

	// 慢速转发:
// 1.方法签名 2.消息转发
#pragma mark - 方法签名
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {

	NSString *methodName = NSStringFromSelector(aSelector);
	if ([methodName isEqualToString:@"sendMessage:"]) {
		return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
	}
	return [super methodSignatureForSelector:aSelector];
}
1
61 10 cimain/Demo
//这个方法是找一个 处理者
-(void)forwardInvocation:(NSInvocation *)anInvocation {
//消息转发
	SEL sel = [anInvocation selector];
	SpareWheel *tempObjc = [SpareWheel new];
	if ([tempObjc respondsToSelector:sel]) {
		[anInvocation invokeWithTarget:tempObjc];
	}else{
		[super forwardInvocation:anInvocation];
	}
}

//-(void)forwardInvocation:(NSInvocation *)anInvocation {
//
//	[super forwardInvocation:anInvocation];
//}

//找不到方法就执行这个
-(void)doesNotRecognizeSelector:(SEL)aSelector {
	NSLog(@"找不到方法");
//	[super doesNotRecognizeSelector:aSelector];
}

@end
