printing
printStatementsOn: aStream level: level

	statements
		do: [:s| s printOn: aStream level: level]
		separatedBy: [aStream nextPut: $.; crtab: level + 1]