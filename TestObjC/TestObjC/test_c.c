//
//  test_c.c
//  TestObjC
//
//  Created by hour on 2018/11/29.
//  Copyright © 2018 hour. All rights reserved.
//

#include "test_c.h"
#include <stdio.h>
#include <Block.h>

typedef int(^IntBlock)(void);

IntBlock makeCounter(int start, int increment) {
    __block int i = start;

    return Block_copy(^ {
        int ret = i;
        i += increment;
        
        return ret;
    });
}

void testblock() {
    IntBlock mycounter = makeCounter(1, 2);
    printf("1 call: %d\n", mycounter());
    printf("2 call: %d\n", mycounter());
    printf("3 call: %d\n", mycounter());
    
    Block_release(mycounter);
}
