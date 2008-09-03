/*

File: MyViewController.m
Abstract: A view controller responsible for managing the Hello World view.

Version: 1.7

Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple Inc.
("Apple") in consideration of your agreement to the following terms, and your
use, installation, modification or redistribution of this Apple software
constitutes acceptance of these terms.  If you do not agree with these terms,
please do not use, install, modify or redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and subject
to these terms, Apple grants you a personal, non-exclusive license, under
Apple's copyrights in this original Apple software (the "Apple Software"), to
use, reproduce, modify and redistribute the Apple Software, with or without
modifications, in source and/or binary forms; provided that if you redistribute
the Apple Software in its entirety and without modifications, you must retain
this notice and the following text and disclaimers in all such redistributions
of the Apple Software.
Neither the name, trademarks, service marks or logos of Apple Inc. may be used
to endorse or promote products derived from the Apple Software without specific
prior written permission from Apple.  Except as expressly stated in this notice,
no other rights or licenses, express or implied, are granted by Apple herein,
including but not limited to any patent rights that may be infringed by your
derivative works or by other works in which the Apple Software may be
incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR
DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF
CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF
APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Copyright (C) 2008 Apple Inc. All Rights Reserved.

*/

#import "MyViewController.h"


@implementation MyViewController

@synthesize textField;
@synthesize label;
@synthesize string;
@synthesize tcptext;
@synthesize switch1;
@synthesize switch2;

- (void)viewDidLoad {
    // When the user starts typing, show the clear button in the text field.
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // When the view first loads, display the placeholder text that's in the
    // text field in the label.
    label.text = textField.placeholder;
}


- (void)updateString {
	
	// Store the text of the text field in the 'string' instance variable.
	self.string = textField.text;
    // Set the text of the label to the value of the 'string' instance variable.
	label.text = self.string;
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	// When the user presses return, take focus away from the text field so that the keyboard is dismissed.
	if (theTextField == textField) {
		[textField resignFirstResponder];
        // Invoke the method that changes the greeting.
        [self updateString];
	}
	return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [textField resignFirstResponder];
    // Revert the text field to the previous value.
    //textField.text = self.string; 
    [super touchesBegan:touches withEvent:event];
	

}


- (void)dealloc {
	// To adhere to memory management rules, release the instance variables.
    // 'textField' and 'label' are objects in the nib file and are created when the nib
    // is loaded.
	[textField release];
	[label release];
	[super dealloc];
}

/*
[switchObj1 addTarget:self action:@selector(switchAction1 forControlEvents:UIControlEventValueChanged];
											cell.accessoryView = switchObj;
											[switchObj release];
*/											
- (void)switchAction1:(id)sender
{
	
	NSLog(@"starting");

	if( [sender isOn] )
	{
		label.text = [NSString stringWithFormat:@"its on!" ];
		self.tcptext =  [[NSString alloc] initWithString:@"GREETING 3 LOLSCRIPT 13 Mixxx.play(1) MESSAGE 5 IPHONE\r\n"];
		NSLog(@"t -%@", self.tcptext);
		//[NSString stringWithFormat:@"GREETING 3 LOLSCRIPT 13 Mixxx.play(1) MESSAGE 5 IPHONE\r\n"];
		//textField.text = [NSString stringWithFormat:@"GREETING 3 LOLSCRIPT 13 Mixxx.play(1) MESSAGE 5 IPHONE\r\n"];
	}
	else
	{
		self.tcptext =  [[NSString alloc] initWithString:@"GREETING 3 LOLSCRIPT 13 Mixxx.stop(1) MESSAGE 5 IPHONE\r\n"];
		NSLog(@"t -%@", self.tcptext);
		label.text = [NSString stringWithFormat:@"its off!" ];
		//		self.tcptext = [NSString stringWithFormat:@"GREETING 3 LOLSCRIPT 13 Mixxx.stop(1) MESSAGE 5 IPHONE\r\n"];
	}	
	NSLog(@"starting2");
	m_writetext = true;
	
	
	NSLog(@"connecting");
	//int kServerPort = 8887;
	[self connectToHostName:textField.text port:8887];
	[self openStreams];
	NSLog(@"finished");


}

- (void)switchAction2:(id)sender
{

	
	NSLog(@"starting");
	
	if( [sender isOn] )
	{
		label.text = [NSString stringWithFormat:@"its on!" ];
		self.tcptext =  [[NSString alloc] initWithString:@"GREETING 3 LOLSCRIPT 13 Mixxx.play(2) MESSAGE 5 IPHONE\r\n"];
		NSLog(@"t -%@", self.tcptext);
		//[NSString stringWithFormat:@"GREETING 3 LOLSCRIPT 13 Mixxx.play(1) MESSAGE 5 IPHONE\r\n"];
		//textField.text = [NSString stringWithFormat:@"GREETING 3 LOLSCRIPT 13 Mixxx.play(1) MESSAGE 5 IPHONE\r\n"];
	}
	else
	{
		self.tcptext =  [[NSString alloc] initWithString:@"GREETING 3 LOLSCRIPT 13 Mixxx.stop(2) MESSAGE 5 IPHONE\r\n"];
		NSLog(@"t -%@", self.tcptext);
		label.text = [NSString stringWithFormat:@"its off!" ];
		//		self.tcptext = [NSString stringWithFormat:@"GREETING 3 LOLSCRIPT 13 Mixxx.stop(1) MESSAGE 5 IPHONE\r\n"];
	}	
	NSLog(@"starting2");
	m_writetext = true;
	
	
	NSLog(@"connecting");
	//int kServerPort = 8887;
	[self connectToHostName:textField.text port:8888];
	[self openStreams];
	NSLog(@"finished"); 
}



- (void) connectToHostName:(NSString *)hostname port:(unsigned short)port
{
	//    NSInputStream * inputStream;
	//   NSOutputStream * outputStream;
    
/*	if (inputStream && outputStream) {
        [self closeStreamsSimples];
    }
*/	
    NSHost * host = [NSHost hostWithName:hostname];
	inputStream = nil;
	outputStream = nil;
	[NSStream getStreamsToHost:host port:port inputStream:&inputStream outputStream:&outputStream];
	
    //[inputStream setDelegate:self];
    //[outputStream setDelegate:self];
    
    NSLog(@"Connected!");
    /*
	 [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	 [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	 
	 [inputStream open];
	 [outputStream open];
	 */
	[self openStreams];
}

#pragma mark -
#pragma mark Stream methods

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)streamEvent {
    NSInputStream * istream;
    switch(streamEvent) {
        case NSStreamEventHasBytesAvailable:;
			
			NSLog(@"got data");

			uint8_t buffer[128];
			int len;
			while ([inputStream hasBytesAvailable])
			{
				len = [inputStream read:buffer maxLength:sizeof(buffer)];
				NSLog(@"%d", len);
				if (len > 0)
				{
					NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
					if (nil != output)
					{
						NSLog(@"%@", output);
						[output release];
					}
				}
			}
			 break;
			 
        case NSStreamEventHasSpaceAvailable:
			
			if (aStream == outputStream) {
				NSLog(@"Woot!");
				//                NSString * str = [NSString stringWithFormat:@"GET / HTTP/1.0\r\n\r\n"];
				
				NSLog(@"%@", self.tcptext);
				if( m_writetext == true)
				{
					NSString * str =  [NSString stringWithFormat:@"GREETING 3 LOLSCRIPT 13 Mixxx.play(1) MESSAGE 5 IPHONE\r\n"];
					
					const uint8_t * rawstring =		(const uint8_t *)[self.tcptext UTF8String];
					
					[outputStream write:rawstring maxLength:strlen(rawstring)];
					m_writetext = false;
				}
			
				
				//[outputStream close];
                 [self closeStreamsSimple];
				
            }
			
            break;
			
        case NSStreamEventEndEncountered:;
            [self closeStreamsSimple];
            break;
        case NSStreamEventErrorOccurred:
			break;			
        case NSStreamEventNone:
			//event = @"NSStreamEventNone";
			textField.font = [UIFont fontWithName:@"Helvetica" size:10.0];
			textField.textColor = [UIColor whiteColor];
			textField.text = [[NSString alloc] initWithFormat: @"Can not connect to the host!"];
			NSLog(@"Con't connect to host");
			break;
		case NSStreamEventOpenCompleted:
			//event = @"NSStreamEventOpenCompleted";
			break;
		default:
            break;
    }
}



- (void)openStreams {
    [inputStream retain];
    [outputStream retain];
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
}

- (void)openStreamsSimple {
    [inputStream open];
    [outputStream open];
}


- (void)closeStreamsSimple {
		[inputStream close];
		[outputStream close];
		[inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[inputStream setDelegate:nil];
		[outputStream setDelegate:nil];
		[inputStream release];
		[outputStream release];
		inputStream = nil;
		outputStream = nil;
}

@end
