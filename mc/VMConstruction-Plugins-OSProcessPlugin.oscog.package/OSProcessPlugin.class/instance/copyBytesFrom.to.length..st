private - conversion
copyBytesFrom: charArray1 to: charArray2 length: len
	"self cCode: 'memcpy(charArray2, charArray1, len'"

	<var: 'charArray1' type: 'void *'>
	<var: 'charArray2' type: 'void *'>
	self mem: charArray2 cp: charArray1 y: len
