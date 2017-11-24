//
//  SDHtmlLabel.h
//  FBSnapshotTestCase
//
//  Created by Lorenzo Rossi on 21/11/17.
//  Copyright © 2017 Sysdata. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDHtmlLabelProtocol <NSObject>

@optional
- (NSArray*)getCustomTagWhiteList;

@end

@interface SDHtmlLabel : UILabel

@property (nonatomic, weak) id<SDHtmlLabelProtocol> delegate;

- (void)setHtmlText:(NSString*)htmlText;

@end
