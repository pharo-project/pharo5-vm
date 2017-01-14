primitive support
successful
	"Answer the state of the primitive failure code/success flag.  If
	 primFailCode is non-zero a primitive has failed.  If primFailCode
	 is greater than one then its value indicates the reason for failure."
	<inline: true>
	
	"In C, non-zero is true, so avoid computation by using not the C version."
	^self cCode: [primFailCode not] inSmalltalk: [primFailCode = 0]