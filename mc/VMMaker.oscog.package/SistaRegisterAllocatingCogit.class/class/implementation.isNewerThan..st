clone maintennance
implementation: aMethodReference isNewerThan: bMethodReference
	^(self dateAndTimeFrom: aMethodReference timeStamp) > (self dateAndTimeFrom: bMethodReference timeStamp)