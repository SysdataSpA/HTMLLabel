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
    NSString *_htmlSource;
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

- (void)setHtmlText:(NSString*)htmlText
{
    NSArray *whiteList = _tagWhiteList;
    if ([_delegate respondsToSelector:@selector(getCustomTagWhiteList)])
        whiteList = [_delegate getCustomTagWhiteList];
        
    _htmlSource = [self stripHtml:htmlText withTagWhiteList:whiteList];
    
    NSString *htmlWithFont = [self getHtmlWithLabelFont];
    [self setHtmlAttributedString:htmlWithFont];
}

- (void)setText:(NSString *)text
{
    if (_htmlSource)
        _htmlSource = nil;
    
    [super setText:text];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (_htmlSource && !_htmlLoading)
        _htmlSource = nil;
    
    [super setAttributedText:attributedText];
}

- (NSString*)getHtmlWithLabelFont
{
    return [NSString stringWithFormat:@"<span style=\"font-family:'%@'; font-size:'%fpx';\">%@</span>",
            self.font.fontName,
            self.font.pointSize,
            _htmlSource];
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
    
    if (_htmlSource) {
        NSString *htmlWithFont = [self getHtmlWithLabelFont];
        [self setHtmlAttributedString:htmlWithFont];
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
