plugin extra rules
configurePlugin: aPlugin with: generator

	^ self perform: ( 'configure' , aPlugin name , ':' ) asSymbol with: generator.
	