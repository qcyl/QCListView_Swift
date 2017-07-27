//
//  ProtocolDispatcher.h
//  checkAPP
//
//  Created by qi chao on 2017/1/16.
//
//

#import <Foundation/Foundation.h>

#define AOProtocolDispatcher(__protocol__, ...)  \
    [ProtocolDispatcher dispatcherProtocol:@protocol(__protocol__)  \
                            toImplemertors:[NSArray arrayWithObjects:__VA_ARGS__, nil]]

@interface ProtocolDispatcher : NSObject

+ (id<UITableViewDelegate>)dispatcherProtocol:(Protocol *)protocol toImplemertors:(NSArray *)implemertors;

@end
