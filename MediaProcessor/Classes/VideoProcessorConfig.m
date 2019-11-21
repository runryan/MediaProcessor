//
//  VideoProcessorConfig.m
//  TXUGCUploaderExample
//
//  Created by ryan on 2019/11/20.
//  Copyright © 2019 windbird. All rights reserved.
//

#import "VideoProcessorConfig.h"

@implementation VideoProcessorConfig

- (instancetype)init {
    if(self = [super init]) {
        self.outputFileType = AVFileTypeMPEG4;
        self.presetName = AVAssetExportPresetPassthrough;
        self.timeRange = CMTimeRangeMake(kCMTimeZero, kCMTimePositiveInfinity);
        self.shouldOptimizeForNetworkUse = YES;
    }
    return self;
}

@end
