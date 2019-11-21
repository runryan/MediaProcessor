//
//  VideoProcessorConfig.h
//  TXUGCUploaderExample
//
//  Created by ryan on 2019/11/20.
//  Copyright © 2019 windbird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoProcessorConfig : NSObject

@property(nonatomic, copy, nonnull)  NSURL *originalVideoURL;
@property(nonatomic, copy, nonnull)  NSURL *outputURL;
@property(nonatomic, copy, nullable)  NSString *presetName;
@property(nonatomic, copy, nullable)  AVFileType outputFileType;
@property(nonatomic, assign) CMTimeRange timeRange;
@property(nonatomic, assign) BOOL shouldOptimizeForNetworkUse;

@end

NS_ASSUME_NONNULL_END
