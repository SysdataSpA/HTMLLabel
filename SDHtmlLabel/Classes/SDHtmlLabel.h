//
//  SDHtmlLabel.h
//  FBSnapshotTestCase
//
//  Created by Lorenzo Rossi on 21/11/17.
//  Copyright © 2017 Sysdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDHtmlStyle.h"

@class SDHtmlLabel;

@protocol SDHtmlLabelProtocol <NSObject>

@optional
- (NSArray*)getCustomTagWhiteList:(SDHtmlLabel*)sender;
- (SDHtmlStyle*)getDefaultStyle:(SDHtmlLabel*)sender;

@end

@interface SDHtmlLabel : UILabel

@property (nonatomic, weak) id<SDHtmlLabelProtocol> delegate;

@property (nonatomic, strong) NSString* textHtml;

@end
