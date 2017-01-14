weakness and ephemerality
isScavengeSurvivor: oop
	"Answer whether the oop has survived a scavenge.  This is equivalent to
		| target |
		(manager isImmediate: oop) ifTrue:
			[^true].
		target := (manager isForwarded: oop)
					ifTrue: [manager followForwarded: oop]
					ifFalse: [oop].
	 	^((manager isInEden: target)
		  or: [(manager isInPastSpace: target)]) not"
	| target |
	(manager isImmediate: oop) ifTrue:
		[^true].
	(manager isForwarded: oop)
		ifTrue: [target := manager followForwarded: oop]
		ifFalse: [target := oop].
	^(manager isReallyYoung: target) not
	  or: [manager isInFutureSpace: target]