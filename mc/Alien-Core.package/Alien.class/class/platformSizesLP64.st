platform
platformSizesLP64
	"64-bit Unix, including Mac OS X"
	^ IdentityDictionary new
		add: #char -> 1;
		add: #short -> 2;
		add: #int -> 4;
		add: #long -> 8;
		add: #longLong -> 8;
		add: #float -> 4;
		add: #double -> 8;
		add: #pointer -> 8;
		yourself