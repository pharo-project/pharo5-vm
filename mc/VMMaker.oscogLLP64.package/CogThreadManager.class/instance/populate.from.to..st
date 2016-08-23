thread set
populate: vmThreadPointers from: start to: finish
	"Populate vmThreadPointers with vmThreads over the given range."
	<var: #vmThreadPointers type: #'CogVMThread **'>
	| nThreads vmThreads |
	<var: #vmThreads type: #'CogVMThread *'>
	<var: #vmThread type: #'CogVMThread *'>
	<inline: true>
	nThreads := finish - start + 1.
	vmThreads := self cCode: [self c: nThreads alloc: (self sizeof: CogVMThread)]
						inSmalltalk: [CArrayAccessor on: ((1 to: nThreads) collect: [:ign| CogVMThread new])].
	vmThreads isNil ifTrue:
		[^false].
	self cCode:
			[start = 1 ifTrue:
				[vmThreadPointers at: 0 put: nil]]
		inSmalltalk: [].
	start to: finish do:
		[:i| | vmThread |
		vmThread := self addressOf: (vmThreads at: i - start).
		(self ioNewOSSemaphore: (self cCode: [self addressOf: vmThread osSemaphore]
										inSmalltalk: [[:sem| vmThread osSemaphore: sem]])) ~= 0 ifTrue:
			[start to: i - 1 do:
				[:j|
				vmThread := self addressOf: (vmThreads at: j - start).
				self ioDestroyOSSemaphore: (self addressOf: vmThread osSemaphore)].
			self free: vmThreads.
			^false].
		vmThreadPointers at: i put: vmThread.
		vmThread awolProcLength: AWOLProcessesIncrement.
		vmThread index: i].
	^true