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
    
    if (styleElement.textColor.length > 0) {
        [styleString appendString:[NSString stringWithFormat:@"color: %@;", styleElement.textColor]];
    }
    
    if (styleElement.textAlign.length > 0) {
        [styleString appendString:[NSString stringWithFormat:@"text-align: %@;", styleElement.textAlign]];
    }
    
    if (styleElement.textLineHeight > 0) {
        [styleString appendString:[NSString stringWithFormat:@"line-height: %dpx;", styleElement.textLineHeight]];
    }
    
    return styleString;
}

@end
