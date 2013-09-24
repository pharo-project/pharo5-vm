class table
classTablePageSize
	"1024 entries per page (2^10); 22 bit classIndex implies 2^12 pages"
	"self basicNew classTablePageSize"
	^1 << self classTableMajorIndexShift