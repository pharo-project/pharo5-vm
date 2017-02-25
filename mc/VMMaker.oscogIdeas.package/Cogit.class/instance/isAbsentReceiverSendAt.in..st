simulation only
isAbsentReceiverSendAt: mcpc in: cogHomeMethod
	| prev this |
	self mapFor: cogHomeMethod
		do: [:a :m|
			m < mcpc
				ifTrue: [prev := a]
				ifFalse: [m = mcpc ifTrue: [this := a]].
			false].
	^this = IsSendCall and: [prev = IsNSSendCall]