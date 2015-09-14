//
//  DribbleAppInfo.m
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "DribbleAppInfo.h"

@implementation DribbleAppInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"page": @"page",
             @"pages": @"pages",
             @"total": @"total",
             };
}

+ (NSValueTransformer *)shotsJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:ShotsModel.class];
}

@end
