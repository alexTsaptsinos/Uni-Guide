//
//  HomeModel.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeModelProtocol <NSObject>

-(void)itemsDownloaded:(NSArray *)items;

@end

@interface HomeModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic,weak) id<HomeModelProtocol> delegate;

- (void)downloadItems;

@end
