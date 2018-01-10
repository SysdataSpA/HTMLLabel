//
//  SDHtmlLabel.m
//  FBSnapshotTestCase
//
//  Created by Lorenzo Rossi on 21/11/17.
//  Copyright © 2017 Sysdata. All rights reserved.
//

#import "SDHtmlLabel.h"

@implementation SDHtmlLabel
{
    NSString *_textHtmlStripped;
    BOOL _htmlLoading;
}

static NSArray *_tagWhiteList;

+ (void)initialize {
    _tagWhiteList = @[@"h1", @"h2", @"h3", @"h4", @"h5", @"h6",
                      @"p",
                      //@"a",
                      @"style",
                      @"q",
                      @"br",
                      @"font",
                      //@"img",
                      @"hr",
                      @"var",
                      @"center",
                      @"ul", @"li",
                      @"div", @"span",
                      @"big", @"strong", @"small", @"strike", @"code", @"em", @"cite", @"i", @"b", @"u", @"tt"];
}

- (void)setTextHtml:(NSString*)textHtml
{
    _textHtml = textHtml;
    
    NSArray *whiteList = _tagWhiteList;
    if ([_delegate respondsToSelector:@selector(getCustomTagWhiteList:)])
        whiteList = [_delegate getCustomTagWhiteList:self];
        
    _textHtmlStripped = [self stripHtml:textHtml withTagWhiteList:whiteList];
    
    NSString *htmlWithStyle = [self getHtmlWithStyle];
    [self setHtmlAttributedString:htmlWithStyle];
}

- (void)setText:(NSString *)text
{
    if (_textHtmlStripped)
        _textHtmlStripped = nil;
    
    [super setText:text];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (_textHtmlStripped && !_htmlLoading)
        _textHtmlStripped = nil;
    
    [super setAttributedText:attributedText];
}

- (NSString*)getHtmlWithStyle
{
    if ([_delegate respondsToSelector:@selector(getDefaultStyle:)]) {
        SDHtmlStyle *defaultStyle = [_delegate getDefaultStyle:self];
        if (defaultStyle) {
            return [defaultStyle applyHtmlStyleToString:_textHtmlStripped];
        }
    }
    
    return [NSString stringWithFormat:@"<span style=\"font-family:'%@'; font-size:'%fpx';\">%@</span>",
            self.font.fontName,
            self.font.pointSize,
            _textHtmlStripped];
}

- (void)setHtmlAttributedString:(NSString*)htmlText
{
    NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[htmlText dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                          NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                     documentAttributes:nil error:nil];
    _htmlLoading = true;
    @try {
        self.attributedText = attr;
    }
    @finally {
        _htmlLoading = false;
    }
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    if (_textHtmlStripped) {
        NSString *htmlWithStyle = [self getHtmlWithStyle];
        [self setHtmlAttributedString:htmlWithStyle];
    }
}

-(NSString *) stripHtml:(NSString*)htmlString withTagWhiteList:(NSArray*)whiteList {
    NSMutableString *whiteListString = [NSMutableString new];
    for (NSString *tag in whiteList)
    {
        if (whiteListString.length > 0)
            [whiteListString appendString:@"|"];
        
        [whiteListString appendString:tag];
    }
    
    NSString *strippedHtml = [htmlString copy];
    NSString *regexString = [NSString stringWithFormat:@"<(?!/?(%@)(>|\\s))[^<]+?>", whiteListString];
    
    while ([strippedHtml rangeOfString:regexString options:NSRegularExpressionSearch].location != NSNotFound) {
        NSRange r = [strippedHtml rangeOfString:regexString options:NSRegularExpressionSearch];
        strippedHtml = [strippedHtml stringByReplacingCharactersInRange:r withString:@""];
    }
    
    return strippedHtml;
}

@end
