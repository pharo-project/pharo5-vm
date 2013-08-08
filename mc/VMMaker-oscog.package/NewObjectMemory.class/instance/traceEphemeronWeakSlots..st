ephemerons
traceEphemeronWeakSlots: eph

	" trace all weak slots of ephemeron:
	
	list next ... [value 1 ... valueN key ]
	"
	| end firstWeak |
	
	firstWeak := BaseHeaderSize + ( (self nonWeakFieldsOf: eph) << ShiftForWord).

	end := self ephemeronKeyOffset: eph. 

	[ end >= firstWeak ] whileTrue: [
		| oop |
		oop := self longAt: eph + end.
		self markAndTrace: oop.    	
		end := end - BytesPerWord.
	]

