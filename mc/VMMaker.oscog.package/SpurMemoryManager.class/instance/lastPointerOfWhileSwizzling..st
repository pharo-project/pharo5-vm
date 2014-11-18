snapshot
lastPointerOfWhileSwizzling: objOop 
	"Answer the byte offset of the last pointer field of the given object.
	 Works with CompiledMethods, as well as ordinary objects.
	 Does not examine the stack pointer of contexts to be sure to swizzle
	 the nils that fill contexts on snapshot.
	 It is invariant that on image load no object contains a forwarding pointer,
	 and the image contains no forwarders (see class comment)."
	<api>
	<inline: true>
	| fmt header |
	fmt := self formatOf: objOop.
	self assert: fmt ~= self forwardedFormat.
	fmt <= self lastPointerFormat ifTrue:
		[^(self numSlotsOf: objOop) - 1 * self bytesPerOop + self baseHeaderSize  "all pointers"].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	header := self methodHeaderOf: objOop.
	^self lastPointerOfMethodHeader: header