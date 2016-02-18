assertions
allPagesFree
	<doNotGenerate>
	^pages allSatisfy: [:page| (self isFree: page)]