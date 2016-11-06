method lookup cache
addNewMethodToNSCache: rule
	<option: #NewspeakVM>
	<inline: false>
	| classObj probe hash primitiveIndex |
	classObj := lkupClass.
	hash := (objectMemory methodCacheHashOf: messageSelector with: lkupClassTag) bitXor: (method bitXor: rule).
	self deny: rule = LookupRuleOrdinary.

	(objectMemory isOopCompiledMethod: newMethod)
		ifTrue:
			[primitiveIndex := self primitiveIndexOf: newMethod.
			 primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: classObj]
		ifFalse:
			[self assert: ((objectMemory isNonImmediate: newMethod)
						  and: [objectMemory isForwarded: newMethod]) not.
			 primitiveFunctionPointer := #primitiveInvokeObjectAsMethod].

	0 to: CacheProbeMax-1 do:
		[:p | probe := (hash >> p) bitAnd: NSMethodCacheMask.
		(nsMethodCache at: probe + NSMethodCacheSelector) = 0 ifTrue:
			["Found an empty entry -- use it"
			nsMethodCache at: probe + NSMethodCacheSelector put: messageSelector.
			nsMethodCache at: probe + NSMethodCacheClassTag put: lkupClassTag. "(objectMemory classTagForClass: classObj)."
			nsMethodCache at: probe + NSMethodCacheCallingMethod put: method.
			nsMethodCache at: probe + NSMethodCacheDepthOrLookupRule put: rule.
			nsMethodCache at: probe + NSMethodCacheTargetMethod put: newMethod.
			nsMethodCache at: probe + NSMethodCachePrimFunction put: (self cCoerce: primitiveFunctionPointer to: #'sqIntptr_t').
			nsMethodCache at: probe + NSMethodCacheActualReceiver put: localAbsentReceiverOrZero.
			"lastMethodCacheProbeWrite := probe." "this for primitiveExternalMethod"
			^self]].

	"OK, we failed to find an entry -- install at the first slot..."
	probe := hash bitAnd: NSMethodCacheMask.  "first probe"
	nsMethodCache at: probe + NSMethodCacheSelector put: messageSelector.
	nsMethodCache at: probe + NSMethodCacheClassTag put: lkupClassTag. "(objectMemory classTagForClass: classObj)."
	nsMethodCache at: probe + NSMethodCacheCallingMethod put: method.
	nsMethodCache at: probe + NSMethodCacheDepthOrLookupRule put: rule.
	nsMethodCache at: probe + NSMethodCacheTargetMethod put: newMethod.
	nsMethodCache at: probe + NSMethodCachePrimFunction put: (self cCoerce: primitiveFunctionPointer to: #'sqIntptr_t').
	nsMethodCache at: probe + NSMethodCacheActualReceiver put: localAbsentReceiverOrZero.
	"lastMethodCacheProbeWrite := probe. ""this for primitiveExternalMethod"

	"...and zap the following entries"
	1 to: CacheProbeMax-1 do:
		[:p | probe := (hash >> p) bitAnd: NSMethodCacheMask.
		nsMethodCache at: probe + NSMethodCacheSelector put: 0]