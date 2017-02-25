private
validRelocationPlanInPass: onePass
	"Answer 0 if all the mobile objects from firstMobileObject to lastMobileObject
	 have sane forwarding addresses, and that savedFirstFieldsSpace is of
	 matching capacity.  Otherwise answer an error code identifying the anomaly."
	| nMobiles toFinger |
	<var: 'toFinger' type: #usqInt>
	<var: 'destination' type: #usqInt>
	nMobiles := 0.
	toFinger := mobileStart.
	anomaly := nil.
	manager allOldSpaceEntitiesFrom: firstMobileObject do:
		[:o| | destination |
		 self check: o.
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o) ifFalse:
				[nMobiles := nMobiles + 1.
				 destination := manager fetchPointer: 0 ofObject: o.
				 destination >= toFinger ifFalse:
					[anomaly := o. ^1].
				 toFinger := toFinger + (manager bytesInObject: o).
				 (self oop: o isGreaterThan: lastMobileObject) ifTrue:
					[anomaly := o. ^2].
				 o = lastMobileObject ifTrue:
					[^savedFirstFieldsSpace top + manager bytesPerOop - savedFirstFieldsSpace start / manager bytesPerOop
					   = nMobiles
						ifTrue: [0]
						ifFalse: [3]]]]].
	"N.B. written this way so that if there are no mobiles the expression evaluates to 0 in Smalltalk /and/ in C unsigned arithmetic."
	^savedFirstFieldsSpace top + manager bytesPerOop - savedFirstFieldsSpace start / manager bytesPerOop
	  = nMobiles
		ifTrue: [0]
		ifFalse: [4]