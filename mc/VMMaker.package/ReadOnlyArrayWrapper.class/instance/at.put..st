accessing
at: index put: value
	"Oh where is imutability when you need it??"
	self error: 'attempt to modify memory!!'