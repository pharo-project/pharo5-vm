platform
platformSizesLLP64
	"MS Windows 64-bit"
	^ IdentityDictionary new
		add: #char -> 1;
		add: #short -> 2;
		add: #int -> 4;
		add: #long -> 4;
		add: #longLong -> 8;
		add: #float -> 4;
		add: #double -> 8;
		add: #pointer -> 8;
		yourself