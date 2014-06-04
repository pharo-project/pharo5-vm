initialization
checkCompactIndex: compactIndex isClass: specialIndex named: name
	"Check that a class the VM assumes is compact has the right index."
	<inline: true> "macrofication of the name arg in invalidCompactClassError only works if this method is inlined so the name is a string literal not a parameter"
	(compactIndex ~= 0
	 and: [(self splObj: specialIndex) ~= (self compactClassAt: compactIndex)]) ifTrue:
		[self invalidCompactClassError: name]