*Cog-method prototypes
WeakRegistryPROTOTYPEfinalizeValues
	"Finalize any values, which happen to stocked in our list, due to some weak references become garbage"
	
	| finalizer |

	" Do the old way, if VM don't supports us"
	WeakFinalizationList hasNewFinalization ifFalse: [
		self protected: [
			valueDictionary finalizeValues.
			finalizer := executors.
			executors := nil ].
		finalizer ifNotNil: [
			finalizer do: [ :each | each ifNotNil: [ each finalizeValues ] ] ].
		^ self ].

	self protected: [ finalizer := list swapWithNil ].

	"We don't need to protect a following loop from concurrent access,
	because at the moment we're finalizing values, 
	only we can access this list of finalizers, because valueDictionary already see them
	as an unused slots, because they're associated with key == nil"
	[ finalizer notNil ] whileTrue: [ | next |
		next := finalizer next.
		[ finalizer finalizeValues] 
		on: Exception fork: [:ex |  ex pass ].
		finalizer := next ]