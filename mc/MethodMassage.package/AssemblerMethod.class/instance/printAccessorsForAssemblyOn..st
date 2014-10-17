printing
printAccessorsForAssemblyOn: aStream
	| dummy |
	dummy := self class new initializeForAssembly.
	"Generate all the accessors; for now don't handle the trailer"
	#(			compiledMethodClass: methodClass: selector: primitive:
				numArgs: numTemps: frameSize: flag: signFlag: trailerData:)
		with: #(	compiledMethodClass methodClass selector primitive
				numArgs numTemps frameSize flag signFlag trailerData)
		do: [:setter :getter|
			(self perform: getter) ifNotNil:
				[:val|
				val ~= (dummy perform: getter) ifTrue:
					[aStream crtab; nextPutAll: setter; space; print: val; nextPut: $;]]]