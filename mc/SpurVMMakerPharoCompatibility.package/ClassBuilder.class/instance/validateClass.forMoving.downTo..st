validation
validateClass: srcClass forMoving: iv downTo: dstClass
	"Make sure that we don't have any accesses to the instVar left"
	srcClass withAllSubclassesDo:[:cls|
		(cls == dstClass or:[cls inheritsFrom: dstClass]) ifFalse:[
			(cls whichSelectorsAccess: iv) isEmpty ifFalse:[
				self notify: (iv printString asText allBold), ' is still used in ', cls name asText allBold,'.
Proceed to move it to Undeclared'.
			].
		].
	].
	^true