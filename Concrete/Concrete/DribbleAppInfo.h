//
//  DribbleAppInfo.h
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "ShotsModel.h"


@interface DribbleAppInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *pages;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) ShotsModel *shots;



@end
