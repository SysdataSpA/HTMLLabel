//
//  SDHtmlStyle.h
//  FBSnapshotTestCase
//
//  Created by Lorenzo Rossi on 09/01/18.
//

#import <Foundation/Foundation.h>

@interface SDHtmlStyleElement : NSObject

@property (nonatomic, strong) NSString*         fontFamily;
@property (nonatomic, assign) int               fontSize;
@property (nonatomic, strong) UIColor*          textColor;
@property (nonatomic, assign) NSTextAlignment   textAlign;
@property (nonatomic, assign) int               textLineHeight;
@property (nonatomic, strong) NSDictionary*     additionalCustomAttributes;

@end

@interface SDHtmlStyle : NSObject

@property (nonatomic, strong) SDHtmlStyleElement* bodyStyle;
@property (nonatomic, strong) SDHtmlStyleElement* h1Style;
@property (nonatomic, strong) SDHtmlStyleElement* h2Style;
@property (nonatomic, strong) SDHtmlStyleElement* h3Style;
@property (nonatomic, strong) SDHtmlStyleElement* pStyle;

- (NSString*)applyHtmlStyleToString:(NSString*)htmlString;

@end
