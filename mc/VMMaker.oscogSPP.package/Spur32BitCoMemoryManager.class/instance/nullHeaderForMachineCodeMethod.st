garbage collection
nullHeaderForMachineCodeMethod
	<api>
	<returnTypeC: #sqLong>
	^(self firstLongFormat << self formatShift)
	+ (1 << self markedBitFullShift)
	+ ClassBitmapCompactIndex