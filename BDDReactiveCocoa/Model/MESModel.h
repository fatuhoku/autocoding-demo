//
// Created by Hok Shun Poon on 18/03/2014.
// Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MESModel : NSObject
@property (nonatomic, strong) NSString* string;

- (instancetype)initWithString:(NSString *)string;

+ (instancetype)modelWithString:(NSString *)string;

@end