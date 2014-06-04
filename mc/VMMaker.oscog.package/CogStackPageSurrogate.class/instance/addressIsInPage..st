testing
addressIsInPage: address
	"For assert-checking"
	^self lastAddress < address and: [address < self baseAddress]