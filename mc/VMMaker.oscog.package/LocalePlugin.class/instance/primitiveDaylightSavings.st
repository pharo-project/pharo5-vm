system primitives
primitiveDaylightSavings
	"return a boolean specifying the DST setting. true -> active"
	self primitive:'primitiveDaylightSavings'.
	^self sqLocDaylightSavings asOop: Boolean