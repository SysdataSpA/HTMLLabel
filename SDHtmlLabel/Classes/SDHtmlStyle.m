//
//  SDHtmlStyle.m
//  FBSnapshotTestCase
//
//  Created by Lorenzo Rossi on 09/01/18.
//

#import "SDHtmlStyle.h"

@implementation SDHtmlStyleElement

@end

@implementation SDHtmlStyle

- (NSString*)applyHtmlStyleToString:(NSString*)htmlString
{
    NSMutableString *finalString = [[NSMutableString alloc] initWithString:@"<head><style>"];
   
    if (_bodyStyle) {
        [finalString appendFormat:@"body {%@}", [self createStyleAttributeFromStyleElement: _bodyStyle]];
    }
    
    if (_h1Style) {
        [finalString appendFormat:@"h1 {%@}", [self createStyleAttributeFromStyleElement: _h1Style]];
    }
    
    if (_h2Style) {
        [finalString appendFormat:@"h2 {%@}", [self createStyleAttributeFromStyleElement: _h2Style]];
    }
    
    if (_h3Style) {
        [finalString appendFormat:@"h3 {%@}", [self createStyleAttributeFromStyleElement: _h3Style]];
    }
    
    if (_pStyle) {
        [finalString appendFormat:@"p {%@}", [self createStyleAttributeFromStyleElement: _pStyle]];
    }
    
    [finalString appendFormat:@"</style></head><body>%@</body>", htmlString];
    
    return finalString;
}

- (NSString*)createStyleAttributeFromStyleElement:(SDHtmlStyleElement*)styleElement
{
    NSMutableString *styleString = [NSMutableString new];

    if (styleElement.fontFamily.length > 0) {
        [styleString appendString:[NSString stringWithFormat:@"font-family: %@;", styleElement.fontFamily]];
    }
    
    if (styleElement.fontSize > 0) {
        [styleString appendString:[NSString stringWithFormat:@"font-size: %dpx;", styleElement.fontSize]];
    }
    
    if (styleElement.textColor) {        
        [styleString appendString:[NSString stringWithFormat:@"color: %@;", [self hexStringFromColor:styleElement.textColor]]];
    }
    
    if (styleElement.textAlign != NSTextAlignmentLeft) {
        NSString *textAlign = @"left";
        switch (styleElement.textAlign) {
            case NSTextAlignmentRight:
                textAlign = @"right";
                break;
            case NSTextAlignmentCenter:
                textAlign = @"center";
                break;
            default:
                break;
        }
        
        [styleString appendString:[NSString stringWithFormat:@"text-align: %@;", textAlign]];
    }
    
    if (styleElement.textLineHeight > 0) {
        [styleString appendString:[NSString stringWithFormat:@"line-height: %dpx;", styleElement.textLineHeight]];
    }
    
    return styleString;
}

- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

@end
