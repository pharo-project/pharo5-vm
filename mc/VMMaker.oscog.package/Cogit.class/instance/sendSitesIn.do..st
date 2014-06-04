analysis
sendSitesIn: cogMethod do: binaryBlock
	"Evaluate binaryBlock with the annotation and mcpc for each send site in cogMethod"
	<doNotGenerate>
	self mapFor: cogMethod
		 performUntil: (#withAnnotation:mcpc:evaluate:)
		 arg: [:ann :mcpc | (self isSendAnnotation: ann) ifTrue: [binaryBlock value: ann value: mcpc]]