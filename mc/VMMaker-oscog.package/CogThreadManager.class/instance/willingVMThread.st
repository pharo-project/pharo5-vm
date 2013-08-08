thread set
willingVMThread
	"Answer a pointer to a live CogVMThread in any of the ``will do VM work''
	 states (other than the current owner if the VM is owned), or nil if none.
	 Preferentially answer threads wanting ownership."
	<returnTypeC: #'CogVMThread *'>
	| thread threadWantingVM threadWilling |
	<inline: false>
	<var: #thread type: #'CogVMThread *'>
	<var: #threadWantingVM type: #'CogVMThread *'>
	<var: #threadWilling type: #'CogVMThread *'>
	threadWantingVM := threadWilling := nil.
	1 to: numThreads do:
		[:i|
		 i ~= vmOwner ifTrue:
			[thread := threads at: i.
			 thread state =  CTMWantingOwnership ifTrue:
				[(threadWantingVM isNil
				  or: [threadWantingVM priority < thread priority]) ifTrue:
					[threadWantingVM := thread]].
			 thread state =  CTMAssignableOrInVM ifTrue:
				[(threadWilling isNil
				  or: [threadWilling priority < thread priority]) ifTrue:
					[threadWilling := thread]]]].
	threadWantingVM ifNotNil:
		[^threadWantingVM].
	threadWilling ifNotNil:
		[^threadWilling].
	^nil