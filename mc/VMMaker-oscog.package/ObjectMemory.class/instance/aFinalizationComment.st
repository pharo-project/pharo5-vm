finalization
aFinalizationComment
	"This finalization scheme assumes to have weak classes in which the fields are not traced during the mark phase of a GC. This means, if an object is referenced only by any instances of weak classes it can be collected. In turn, we need to find out if an object referenced by a weak class is actually being collected because we have to invalidate the weak object pointer and to signal that the object has gone.
	How do we know that an object referenced by a weak class is being collected? Well,  this is based on two observations. First, objects will not change their relative locations in memory, meaning that if object A is created BEFORE object B it will always have a physical memory address which is LESS than B. Secondly, GC always works from a given starting address (youngStart during incremental GC; startOfMemory during fullGC) up to end of memory. If we can somehow guarantee that the weak reference is created after the object it points to we can easily implement the following simple scheme:
	1) Mark phase
		Do not trace the fields of any instances of weak classes.
	2) Sweep phase:
		a) Explicitly mark all free objects.
		b) 	If a weak reference is encountered check the the object it points to. 
			If the object is marked as free than we know that this weak reference's object is gone.
			Signal that it is gone.

	There is, however, one small problem with this approach. We cannot always guarantee that WeakReferences point backwards such as in the following piece of code:
		| o1 o2 w1 w2 |
		o1 := Object new.
		w1 := WeakReference on: o1.
		o2 := Object new.
		w2 := WeakReference on: o2.
		o1 become: o2.
The become: operation makes w1 point to o2 and because o2 has been created AFTER w1 the object reference in w1 points forward. Why might this be a problem? Well, if the GC would start after the weak reference AND free the object then the weak reference would simply point to an invalid memory location (since we've not been checking the weak reference during sweep phase).

	Fortunately, this can not happen in the current ObjectMemory implementation. Why? Well, the only GC not starting at the beginning of the memory is incremental GC. Incremental GC however is only executed in so-called youngSpace. If both, the weak reference AND the object it points to reside in youngSpace then we can still check the weak reference. If however, the weak reference is not in youngSpace but the object is, then the reference is itself a root for young space and will be processed by the GC.

	In the end, we just need a little adjustment in step 2b) of the above procedure which looks as follows:
		If the weak reference points 
			* backwards: check if the object header is marked free
			* forwards: check if the object has been marked in markPhase.

	Note that a number of finalizations will only be executed during a fullGC. So, if you must guarantee that some object has been finalized you definitely need to do a fullGC.

ar 3/20/98 17:20"

	self error:'Comment only'.