//
//  SDViewController.m
//  SDHtmlLabel
//
//  Created by Lorenzo Rossi on 11/21/2017.
//  Copyright © 2017 Sysdata. All rights reserved.
//

#import "SDViewController.h"
#import <SDHtmlLabel/SDHtmlLabel.h>

@interface SDViewController () <SDHtmlLabelProtocol>
@property (weak, nonatomic) IBOutlet SDHtmlLabel *lblHtml;
@end

@implementation SDViewController
{
    SDHtmlStyle *_style;
    NSString *_htmlString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error = nil;

    NSString* path = [[NSBundle mainBundle] pathForResource:@"testHtmlStyle"
                                                     ofType:@"html"];
    _htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    _lblHtml.delegate = self;
    _lblHtml.textHtml = _htmlString;
}

- (IBAction)loadHtml:(id)sender {
    _lblHtml.textHtml = _htmlString;
    _lblHtml.font = [UIFont systemFontOfSize:_lblHtml.font.pointSize];
}

- (IBAction)loadCustomFont:(id)sender {
    _lblHtml.font = [UIFont fontWithName:@"Pacifico" size:_lblHtml.font.pointSize];
}

- (IBAction)loadPlainText:(id)sender {
    _lblHtml.text = @"This is plain text";
}

#pragma mark SDHtmlLabel delegate
- (SDHtmlStyle *)getDefaultStyle:(SDHtmlLabel*)sender {
    
    if (!_style) {
        _style = [SDHtmlStyle new];
        
        SDHtmlStyleElement *bodyStyle = [SDHtmlStyleElement new];
        bodyStyle.fontSize = 16;
        bodyStyle.textColor = UIColor.blueColor;
        bodyStyle.textAlign = NSTextAlignmentCenter;
        
        SDHtmlStyleElement *h2Style = [SDHtmlStyleElement new];
        h2Style.fontSize = 24;
        h2Style.textColor = UIColor.blueColor;
        
        _style.bodyStyle = bodyStyle;
        _style.h2Style = h2Style;
    }
    
    return _style;
}

@end
