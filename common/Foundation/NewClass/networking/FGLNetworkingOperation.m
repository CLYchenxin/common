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

+ (NSOperationQueue *)networkDelegateQueue
{
    static NSOperationQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    return queue;
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
    
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    [self.connection setDelegateQueue:[[self class] networkDelegateQueue]];
    [self.connection start];
    
    if ([self.delegate respondsToSelector:@selector(networkingOperationDidStart:)]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate networkingOperationDidStart:self];
        }];
    }
}

- (void)cancel
{
    if (![self isFinished] && ![self isCancelled]) {
        [super cancel];
        [self.connection cancel];
        
        NSDictionary *userInfo = nil;
        if ([self.request URL]) {
            userInfo = @{NSURLErrorFailingURLErrorKey : [self.request URL]};
        }
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:userInfo];
        [self connection:self.connection didFailWithError:error];
    }
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

- (void)setState:(FGLOperationState)state
{
    NSString *oldStateKey = [self p_KeyPathFromOperationState:self.state];
    NSString *newStateKey = [self p_KeyPathFromOperationState:state];
    
    if (oldStateKey)    [self willChangeValueForKey:oldStateKey];
    if (newStateKey)    [self willChangeValueForKey:newStateKey];
    _state = state;
    if (oldStateKey)    [self didChangeValueForKey:oldStateKey];
    if (oldStateKey)    [self didChangeValueForKey:newStateKey];
}

- (NSString *)p_KeyPathFromOperationState:(FGLOperationState)state
{
    switch (state) {
        case FGLOperationExecutingState:
            return @"isExecuting";
        case FGLOperationFinishedState:
            return @"isFinished";
        default:
            return nil;
    }
}

@end
