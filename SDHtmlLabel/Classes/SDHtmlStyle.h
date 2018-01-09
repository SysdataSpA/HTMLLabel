//
//  SDHtmlStyle.h
//  FBSnapshotTestCase
//
//  Created by Lorenzo Rossi on 09/01/18.
//

#import <Foundation/Foundation.h>

@interface SDHtmlStyleElement : NSObject

@property (nonatomic, strong) NSString* fontFamily;
@property (nonatomic, assign) int       fontSize;
@property (nonatomic, strong) NSString* textColor;
@property (nonatomic, strong) NSString* textAlign;
@property (nonatomic, assign) int       textLineHeight;

@end

@interface SDHtmlStyle : NSObject

@property (nonatomic, strong) SDHtmlStyleElement* bodyStyle;
@property (nonatomic, strong) SDHtmlStyleElement* h1Style;
@property (nonatomic, strong) SDHtmlStyleElement* h2Style;
@property (nonatomic, strong) SDHtmlStyleElement* h3Style;
@property (nonatomic, strong) SDHtmlStyleElement* pStyle;

- (NSString*)applyHtmlStyleToString:(NSString*)htmlString;

@end
