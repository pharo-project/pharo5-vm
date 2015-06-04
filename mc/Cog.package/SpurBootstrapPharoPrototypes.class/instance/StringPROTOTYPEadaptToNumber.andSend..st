method prototypes
StringPROTOTYPEadaptToNumber: receiver andSend: selector
	"If I am involved in arithmetic with a number, convert me to a number."
	self flag: #todo. "This is needed for the conversion to spur... please remove me"
	^ receiver perform: selector with: self asNumber