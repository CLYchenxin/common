//
//  FGLURLConnectionOperation.m
//  demo
//
//  Created by chen_xin on 15/9/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "FGLNetworkingOperation.h"

typedef NS_ENUM(NSInteger, FGLOperationState) {
    FGLOperationReadyState       = 1,
    FGLOperationExecutingState   = 2,
    FGLOperationFinishedState    = 3,
};

@interface FGLNetworkingOperation () <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    NSMutableData *_responseData;
}

@property (strong, nonatomic) NSURLConnection *connection;
@property (assign, nonatomic) FGLOperationState state;

@property (strong, nonatomic) NSURLResponse *response;
@property (strong, nonatomic) NSError *error;

@end

@implementation FGLNetworkingOperation

+ (void)networkRequestThreadEntryPoint:(id)object
{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"Networking"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread
{
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

- (instancetype)initWithURLString:(NSString *)URLString
{
    NSURL *url = [NSURL URLWithString:URLString];
    if (!url) {
        return nil;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return [self initWithURLRequest:request];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request
{
    assert(request != NULL);
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _request = request;
    _state = FGLOperationReadyState;
    
    return self;
}

#pragma mark - Life Cycle

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting
{
    return self.state == FGLOperationExecutingState;
}

- (BOOL)isFinished
{
    return self.state == FGLOperationFinishedState;
}

- (void)start
{
    if (self.cancelled) {
        self.state = FGLOperationFinishedState;
        return;
    }
    
    self.state = FGLOperationExecutingState;
    
    _responseData = [NSMutableData data];
    
    [self performSelector:@selector(p_operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
}

- (void)cancel
{
    [super cancel];
    [self.connection cancel];
    
    NSDictionary *userInfo = nil;
    if ([self.request URL]) {
        userInfo = @{NSURLErrorFailingURLErrorKey : [self.request URL]};
    }
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:userInfo];
    [self connection:self.connection didFailWithError:error];
}

#pragma mark - Public

- (NSData *)responseData
{
    return [_responseData copy];
}

- (NSString *)responseString
{
    return [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
}

- (void)setState:(FGLOperationState)state {
    
    NSString *oldStateKey = [self p_KeyPathFromOperationState:self.state];
    NSString *newStateKey = [self p_KeyPathFromOperationState:state];
    
    [self willChangeValueForKey:newStateKey];
    [self willChangeValueForKey:oldStateKey];
    _state = state;
    [self didChangeValueForKey:oldStateKey];
    [self didChangeValueForKey:newStateKey];
}

#pragma mark - NSURLConnectionDataDelegate, NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.state = FGLOperationFinishedState;
    
    if ([self.delegate respondsToSelector:@selector(networkingOperationDidFinish:)]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate networkingOperationDidFinish:self];
        }];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.state = FGLOperationFinishedState;
    
    self.error = error;
    
    if ([self.delegate respondsToSelector:@selector(networkingOperationDidFinish:)]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate networkingOperationDidFinish:self];
        }];
    }
}

#pragma mark - Private

- (void)p_cancelConnection
{
    
}

- (void)p_operationDidStart
{
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    [self.connection scheduleInRunLoop:runLoop forMode:NSRunLoopCommonModes];
    [self.connection start];
    
    if ([self.delegate respondsToSelector:@selector(networkingOperationDidStart:)]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate networkingOperationDidStart:self];
        }];
    }
}

- (NSString *)p_KeyPathFromOperationState:(FGLOperationState)state
{
    switch (state) {
        case FGLOperationReadyState:
            return @"isReady";
        case FGLOperationExecutingState:
            return @"isExecuting";
        case FGLOperationFinishedState:
            return @"isFinished";
        default:
            return nil;
    }
}

@end
