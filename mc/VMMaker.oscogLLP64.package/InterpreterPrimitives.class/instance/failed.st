primitive support
failed
	<api>
	<inline: true>
	"In C, non-zero is true, so avoid computation by simply answering primFailCode in the C version."
	^self cCode: [primFailCode] inSmalltalk: [primFailCode ~= 0]