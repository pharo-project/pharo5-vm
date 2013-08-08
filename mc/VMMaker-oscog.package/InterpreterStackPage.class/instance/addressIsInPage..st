testing
addressIsInPage: address
	<var: #address type: #'char *'>
	"For assert-checking"
	^lastAddress < address and: [address < baseAddress]