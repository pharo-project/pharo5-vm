A NSSendCache is an inline cache for Newspeak absent receiver sends, designed and implemented by Ryan Macnak.  These caches are used with four varieties of absent receiver sends:
	absent self send
	absent implciit receiver send
	absent dynamic super send
	absent outer send.

See Cogit>>#linkNSSendCache:classTag:enclosingObject:target:caller: and senders.  These caches have
  - a guarded class id (not an oop)
  - an absent receiver (or 0 if it is the method receiver) (an oop or 0)
  - a target method in the code zone (not an oop)
  - depth (not an oop) the nesting depth of the receiver fror an outer send, or < 0 if not nested
  - numArgs (not an oop)
  - the selector (an oop)

The selector, numArgs and depth are read at link time.  The class id is checked at send time and if it matches, the absentReceiver, enclosingObject numArgs and and target method are read, self being substituted for the absentReceiver if absentReceiver is 0.  numArgs is read for sends with arity > 3 (it is implicit in the trampoline for arities 0 to 3) and used to adjust the stack and insert the relevant receiver.  See genNSSendTrampolineFor:numArgs:enclosingObjectCheck:called:.

Note that the caches themselves are also pinned objects on the heap (a non-object punned word array whose elements are not traced) rather than in the code zone, so GC also needs to trace and update references from Cogged methods to these cache objects.  The absent receiver can be updated or cleared on GC. The selector must be updated on GC. The target method can be updated or cleared on code compaction.  The class id, absent receiver, and target method are weak references. cache->selector and method->cache are strong references..

Instance Variables
	classTag:			<Integer>
	depth:				<Integer>
	enclosingObject:	<Object or 0>
	numArgs:			<Integer>
	selector:			<Object>
	target:				<CogMethod>

classTag
	- classTag of the method receiver for which this is valid (the classTag of self in the method in which the send occurs, not the class of the message receiver)

depth
	- nesting depth for outer sends

enclosingObject
	- the oop of the enclosingObject or 0 if none

numArgs
	- send numArgs

selector
	- the oop of the message's selector

target
	- the target CogMethod or 0 if none
