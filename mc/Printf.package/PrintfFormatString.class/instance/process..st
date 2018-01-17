private
process: arguments
 	arguments asArgumentArrayForFormatString do: 
		[:object | 
		"put any text from the format string into outputStream"
		outputStream nextPutAll: string next. 
		 "get next FormatDescriptor from format and render object as specified"
		format atEnd ifFalse: [outputStream nextPutAll: (format next render: object)]].
        "any remainder is string, if so append to outputStream"
        string atEnd ifFalse: [outputStream nextPutAll: string next]