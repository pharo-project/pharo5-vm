method lookup cache
inlineLookupInNSMethodCacheSel: selector classTag: classTag method: callingMethod lookupRule: lookupRule
	"Like inlineLookupInMethodCacheSel:classTag:, but the cache is additionally key'd by the calling method and lookupRule/depth and additionally answers localAbsentReceiverOrZero."

	| hash probe |
	<inline: true>
	hash := (objectMemory methodCacheHashOf: selector with: classTag) bitXor: (callingMethod bitXor: lookupRule).

	probe := hash bitAnd: NSMethodCacheMask.  "first probe"
	(((((nsMethodCache at: probe + NSMethodCacheSelector) = selector) and:
		[(nsMethodCache at: probe + NSMethodCacheClassTag) = classTag]) and:
		[(nsMethodCache at: probe + NSMethodCacheCallingMethod) = callingMethod]) and:
		[(nsMethodCache at: probe + NSMethodCacheDepthOrLookupRule) = lookupRule]) ifTrue:
			[newMethod := nsMethodCache at: probe + NSMethodCacheTargetMethod.
			primitiveFunctionPointer := self cCoerceSimple: (nsMethodCache at: probe + NSMethodCachePrimFunction)
											to: #'void (*)()'.
			localAbsentReceiverOrZero := nsMethodCache at: probe + NSMethodCacheActualReceiver.
			^true	"found entry in cache; done"].

	probe := (hash >> 1) bitAnd: NSMethodCacheMask.  "second probe"
	(((((nsMethodCache at: probe + NSMethodCacheSelector) = selector) and:
		[(nsMethodCache at: probe + NSMethodCacheClassTag) = classTag]) and:
		[(nsMethodCache at: probe + NSMethodCacheCallingMethod) = callingMethod]) and:
		[(nsMethodCache at: probe + NSMethodCacheDepthOrLookupRule) = lookupRule]) ifTrue:
			[newMethod := nsMethodCache at: probe + NSMethodCacheTargetMethod.
			primitiveFunctionPointer := self cCoerceSimple: (nsMethodCache at: probe + NSMethodCachePrimFunction)
											to: #'void (*)()'.
			localAbsentReceiverOrZero := nsMethodCache at: probe + NSMethodCacheActualReceiver.
			^true	"found entry in cache; done"].

	probe := (hash >> 2) bitAnd: NSMethodCacheMask.
	(((((nsMethodCache at: probe + NSMethodCacheSelector) = selector) and:
		[(nsMethodCache at: probe + NSMethodCacheClassTag) = classTag]) and:
		[(nsMethodCache at: probe + NSMethodCacheCallingMethod) = callingMethod]) and:
		[(nsMethodCache at: probe + NSMethodCacheDepthOrLookupRule) = lookupRule]) ifTrue:
			[newMethod := nsMethodCache at: probe + NSMethodCacheTargetMethod.
			primitiveFunctionPointer := self cCoerceSimple: (nsMethodCache at: probe + NSMethodCachePrimFunction)
											to: #'void (*)()'.
			localAbsentReceiverOrZero := nsMethodCache at: probe + NSMethodCacheActualReceiver.
			^true	"found entry in cache; done"].

	^false