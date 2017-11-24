//
//  SDViewController.m
//  SDHtmlLabel
//
//  Created by Lorenzo Rossi on 11/21/2017.
//  Copyright © 2017 Sysdata. All rights reserved.
//

#import "SDViewController.h"
#import <SDHtmlLabel/SDHtmlLabel.h>

@interface SDViewController ()
@property (weak, nonatomic) IBOutlet SDHtmlLabel *lblHtml;
@end

@implementation SDViewController
{
    NSString *_htmlString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error = nil;

    NSString* path = [[NSBundle mainBundle] pathForResource:@"testHtmlStyle"
                                                     ofType:@"html"];
    _htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    [_lblHtml setHtmlText:_htmlString];
}

- (IBAction)loadHtml:(id)sender {
    [_lblHtml setHtmlText:_htmlString];
    _lblHtml.font = [UIFont systemFontOfSize:_lblHtml.font.pointSize];
}

- (IBAction)loadCustomFont:(id)sender {
    _lblHtml.font = [UIFont fontWithName:@"Pacifico" size:_lblHtml.font.pointSize];
}

- (IBAction)loadPlainText:(id)sender {
    _lblHtml.text = @"This is plain text";
}

@end
