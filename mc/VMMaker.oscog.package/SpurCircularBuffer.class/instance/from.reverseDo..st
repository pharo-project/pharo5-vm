enumerating
from: initialPtr reverseDo: aBlock
	<inline: true>
	| ptr |
	last >= start ifTrue:
		[ptr := initialPtr.
		 first <= last
			ifTrue: "enum in first to last range, last to first"
				[ptr >= first ifTrue:
					[[aBlock value: (manager longAt: ptr).
					  (ptr := ptr - manager wordSize) < first ifTrue:
						[^nil]] repeat]]
			ifFalse: "enum in start to last range, last to start"
				[ptr <= last ifTrue:
					[[ptr >= start] whileTrue:
						[aBlock value: (manager longAt: ptr).
						 ptr := ptr - manager wordSize].
					 ptr := limit].
				 "now enum in first to limit range, limit to first"
				 [ptr >= first] whileTrue:
					[aBlock value: (manager longAt: ptr).
					 ptr := ptr - manager wordSize]]].
	^nil