interpreter access
fetchClassOf: oop 
	| ccIndex |
	<inline: true>
	<asmLabel: false>
	^(self isIntegerObject: oop)
		ifTrue: [self splObj: ClassInteger]
		ifFalse:
			[(ccIndex := (self compactClassIndexOf: oop)) = 0
				ifTrue: [(self classHeader: oop) bitAnd: AllButTypeMask]
				ifFalse: [self compactClassAt: ccIndex]]