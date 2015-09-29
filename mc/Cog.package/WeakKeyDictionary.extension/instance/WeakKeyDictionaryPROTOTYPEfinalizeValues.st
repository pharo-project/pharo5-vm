*Cog-method prototypes
WeakKeyDictionaryPROTOTYPEfinalizeValues
	"Remove and finalize all elements which have nil key"
	
	|  cleanUpAfterRemove |
	tally = 0 ifTrue: [ ^self ].
	cleanUpAfterRemove := false.
	1 to: array size do: [ :index |
		(array at: index) 
			ifNil: [ cleanUpAfterRemove := false ]
			ifNotNil: [ :element |
				element key
					ifNil: [
						finalizer ifNotNil: [ finalizer value: element value ].
						array at: index put: nil.
						tally := tally - 1.
						cleanUpAfterRemove := true ]
					ifNotNil: [ :key |
						cleanUpAfterRemove ifTrue: [
							| newIndex |
							(newIndex := self scanFor: key) = index ifFalse: [
								array 
									at: newIndex put: element;
									at: index put: nil ] ] ] ] ].
	cleanUpAfterRemove ifTrue: [ "Continue rehashing at the front of array"
		self fixCollisionsFrom: array size ]