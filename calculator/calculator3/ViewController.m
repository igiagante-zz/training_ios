//
//  ViewController.m
//  calculator3
//
//  Created by Ignacio Giagante on 18/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()

@property (nonatomic) BOOL typingNumber;
@property (nonatomic) Calculator *calculator;
@property (weak, nonatomic) IBOutlet UILabel *display;
- (IBAction)numberPressed:(id)sender;
- (IBAction)operationPressed:(id)sender;
- (IBAction)equalsPressed:(id)sender;
- (IBAction)clearDisplay:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _calculator = [Calculator alloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numberPressed:(id)sender {
 
    NSString *number = [[sender titleLabel] text];
    
    if (self.typingNumber)
    {
        self.display.text = [self.display.text stringByAppendingString:number];
    } else
    {
        self.display.text = number;
        self.typingNumber = YES;
    }
}

- (IBAction)operationPressed:(id)sender {
    
    self.typingNumber = NO;
    NSString *value = _display.text;
    self.calculator.valueOne = [value doubleValue];
    
    self.calculator.operation = [[sender titleLabel] text];
    
    _display.text = @"";
}

- (IBAction)equalsPressed:(id)sender {
    NSString *value = _display.text;
    self.calculator.valueTwo = [value doubleValue];
    NSString *result = [self.calculator performOperation];
    _display.text = result;
}

- (IBAction)clearDisplay:(id)sender {
    _display.text = @"";
}


@end
