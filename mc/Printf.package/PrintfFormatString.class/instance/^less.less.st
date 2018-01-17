printf
<< object 
	"Render object according to next format descriptor in format. 
	Append it to string"
	"Format description 
	syntax: %{flags}{width}{precision}{long}<operator> 
	
	flags 
		-		left flush 
		+		right flush 
		space	non-negative number are preceeded by a blank 
		#		display integer with a radix indicator (0=octal, 0x=hex, float have .) 
		0		0 is used as left padding character for numbers 
	width		minimum field width (rest is padded) 
	.precision	maximum field width or trailing digits 
	long		ignored 
	operator 
		c		display object as character 
		d		display as integer 
		e,E		float in scientific notation 
		f		display as float 
		g,G		display as f or e,E using least amount of space 
		o		display as octal value 
		s		display as string 
		u		display as unsigned 
		x,X		display as hex value 
	"

	outputStream nextPutAll: string next.
	outputStream nextPutAll: (format next render: object).
	format atEnd ifTrue: 
		[format reset.
		outputStream nextPutAll: string next.
		string reset].
	^self string