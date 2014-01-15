/* sqExternalSemaphores.c
 *	Cross-platform thread-safe external semaphore signalling.
 *
 *	Authors: Eliot Miranda & Brad Fowlow
 *
 *	Copyright (C) 2009 by Teleplace, Inc.
 *
 *	All rights reserved.
 *   
 *   This file is part of Squeak.
 * 
 *   Permission is hereby granted, free of charge, to any person obtaining a
 *   copy of this software and associated documentation files (the "Software"),
 *   to deal in the Software without restriction, including without limitation
 *   the rights to use, copy, modify, merge, publish, distribute, sublicense,
 *   and/or sell copies of the Software, and to permit persons to whom the
 *   Software is furnished to do so, subject to the following conditions:
 * 
 *   The above copyright notice and this permission notice shall be included in
 *   all copies or substantial portions of the Software.
 * 
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 *   DEALINGS IN THE SOFTWARE.
 */

#include "sq.h"
#include "sqAssert.h"
#include "sqAtomicOps.h"
#include "sqMemoryFence.h"

/* This implements "lock-free" signalling of external semaphores where there is
 * no lock between the signal responder (the VM) and signal requestors, but
 * there may be spin-locking between signal requestors, depending on the implem-
 * entation of atomicAddConst.
 *
 * Freedom from locks is very helpful in making the QAudioPlugin function on
 * linux, where the absence of thread priorities for non-setuid programs means
 * we cannot run the QAudioPlugin's ticker in a separate thread and must instead
 * derive it from the interval-timer based signal-driven (software interrupt)
 * heartbeat.  If the external semaphore state is locked while the VM is
 * responding to external semaphore signal requests and the heartbeat interrupts
 * causing a locking request for an external semaphore signal request then the
 * system will deadlock, since the interrupt occurs in the VM thread.
 *
 * Lock freedom is achieved by having an array of request counters, and an array
 * of response counters, one per external semaphore index.  To request a signal
 * the requests are locked and the relevant request is incremented.  To respond
 * to a request the VM increments the corresponding response until it matches
 * the request, signalling the associated semaphore on each increment.
 */

#if !COGMTVM
sqOSThread ioVMThread; /* initialized in the various <plat>/vm/sqFooMain.c */
#endif
extern void forceInterruptCheck(void);
extern sqInt doSignalSemaphoreWithIndex(sqInt semaIndex);

static volatile int sigIndexLow = 0;
static volatile int sigIndexHigh = 0;
static volatile int sigLock = 0;


/* do we need to dynamically grow the queue?  */
#define SQ_DYNAMIC_QUEUE_SIZE 0

/* a hardcoded limit for static-sized queue */
#define SQ_SIGNAL_QUEUE_SIZE 512

#if SQ_DYNAMIC_QUEUE_SIZE
    static int maxPendingSignals = 0;
    static volatile sqInt * signalQueue = 0;
#else
    #define maxPendingSignals SQ_SIGNAL_QUEUE_SIZE
    static sqInt signalQueue [maxPendingSignals];
#endif

static inline int hasPendingSignals(void) {
    return sigIndexLow != sigIndexHigh;
}

static inline int maxQueueSize(void) {
    return maxPendingSignals;
}

/* return a successive index in queue, wrap around in round-robin style */ 
static inline int succIndex(int index) {
    return ((index + 1) == maxQueueSize()) ? 0 : index + 1; 
}




static inline void lockSignalQueue()
{
    volatile int old;
    /* spin to obtain a lock */
    
    do {
        sqLowLevelMFence();        
        sqCompareAndSwapRes(sigLock, 0, 1, old );
    } while (old != 0);
    
}

static inline void unlockSignalQueue() {
    sigLock = 0;
}

/* Setting this at any time other than start-up can potentially lose requests.
 * i.e. during the realloc new storage is allocated, the old contents are copied
 * and then pointersd are switched.  Requests occurring during copying won't
 * be seen if they occur to indices already copied.
 * We could make this safer in the linux case by disabling interrupts, but
 * there is little point.  The intended use is to set the table to some adequate
 * maximum at start-up and avoid locking altogether.
 */

void ioGrowSignalQueue( int n ) {
#if SQ_DYNAMIC_QUEUE_SIZE // ignore, if queue size is static

    /* only to grow */
    if (maxPendingSignals < n) {
		extern sqInt highBit(sqInt);
		int sz = 1 << highBit(n-1);
		assert(sz >= n);
		
        
        sqInt * newBuf = realloc(signalQueue, sz * sizeof(sqInt));

        /* we should lock queue when growing, so nobody can access the queue buffer when we mutate the pointer */
        lockSignalQueue();
        signalQueue = newBuf;
        unlockSignalQueue();
        
		maxPendingSignals = sz;
	}
#endif
}


void
ioInitExternalSemaphores(void)
{
    ioGrowSignalQueue(SQ_SIGNAL_QUEUE_SIZE);
}

/* Signal the external semaphore with the given index.  Answer non-zero on
 * success, zero otherwise.  This function is (should be) thread-safe;
 * multiple threads may attempt to signal the same semaphore without error.
 * An index of zero should be and is silently ignored.
 *
 *  (sig) As well as negative index.
 */
sqInt
signalSemaphoreWithIndex(sqInt index)
{
    int next;
    
	/* An index of zero should be and is silently ignored. */
    if (index <=0)
        return 0;
    
    /* we must use the locking semantics to avoid ABA problem on writing a semaphore index to queue,
     so there is no chance for fetching thread to observe queue in inconsistent state.
     */
    lockSignalQueue();
    
    /* check for queue overflow */
    next = succIndex(sigIndexHigh);
    if (next == sigIndexLow ) {
        
#if SQ_DYNAMIC_QUEUE_SIZE 
        // grow and retry
        unlockSignalQueue();
        ioGrowSignalQueue( maxPendingSignals + 100);
        return signalSemaphoreWithIndex(index);

#else
        unlockSignalQueue();
        // error if queue size is static  (perhaps better would be to sleep for a while and retry?)
        error("External semaphore signal queue overflow");
#endif
    }

    signalQueue[sigIndexHigh] = index;
    /* make sure semaphore index is written before we advance sigIndexHigh */
    sqLowLevelMFence();
    
    sigIndexHigh = next;
    /* reset lock */

    unlockSignalQueue();
    forceInterruptCheck();
	return 1;
}


static inline sqInt fetchQueueItem()
{
    // if queue size is dynamic, we should lock while accessing signalQueue
    #if SQ_DYNAMIC_QUEUE_SIZE
        lockSignalQueue();
    #endif
    sqInt result = signalQueue[sigIndexLow];
    #if SQ_DYNAMIC_QUEUE_SIZE
        unlockSignalQueue();
    #endif
    return result;
}



/* Signal any external semaphores for which signal request(s) are pending in queue.
 * Answer whether a context switch occurred.
 * sigIndexHigh may advance during processing, which is not big deal,
 * since we flushing the queue anyways.
 */

sqInt
doSignalExternalSemaphores(int externalSemaphoreTableSize)
{
    int switched = 0;
 
    while (hasPendingSignals()) {
        if(doSignalSemaphoreWithIndex(fetchQueueItem()))
            switched = 1;
        sigIndexLow = succIndex(sigIndexLow);
    }    
	return switched;
}


#if FOR_SQUEAK_VM_TESTS
/* see e.g. tests/sqExternalSemaphores/unixmain.c */
int
allRequestsAreAnswered(int externalSemaphoreTableSize)
{
    /* yes, it is, otherwise we will get a queue overflow error ;) */
	return 1;
}
#endif /* FOR_SQUEAK_VM_TESTS */



/* Following two are left for compatibility with language side */

void ioSetMaxExtSemTableSize(int n) { 
    /* just ignore */
}

int ioGetMaxExtSemTableSize(void) { 
    // answer an arbitrary large number.. to not confuse image side about it
    return 10000000;
    /*    return maxQueueSize(); */
}


