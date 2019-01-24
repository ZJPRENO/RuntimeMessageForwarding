//
//  ViewController.m
//  OC消息转发机制
//
//  Created by 张俊平 on 2018/12/29.
//  Copyright © 2018 ZHANGJUNPING. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	Person *p = [[Person alloc]init];
	[p sendMessage:@"hello"];
//	objc_msgSend([Person new],@selector(sendMessage:),@"hello");
}


@end
