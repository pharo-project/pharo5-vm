validation
validateClass: srcClass forMoving: iv upTo: dstClass
	"Make sure we don't have this instvar already"
	dstClass withAllSubclassesDo:[:cls|
		(cls == srcClass or:[cls inheritsFrom: srcClass]) ifFalse:[
			cls isPointers ifFalse:[
				self error: dstClass name, ' cannot have instance variables'.
				^false].
			cls instSize >= 254 ifTrue:[
				self error: cls name, ' has more than 254 instance variables'.
				^false].
			(cls instVarNames includes: iv) ifTrue:[
				self notify: (iv printString asText allBold),' is defined in ', cls name asText allBold,'
Proceed to move it up to ', dstClass name asText allBold,' as well'.
				instVarMap at: cls name put: (cls instVarNames copyWithout: iv)].
		].
	].
	^true