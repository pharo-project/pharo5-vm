benchmarking
binarytrees: n to: output
	| minDepth maxDepth stretchDepth check longLivedTree iterations |
	minDepth := 4.
	maxDepth := minDepth + 2 max: n.
	stretchDepth := maxDepth + 1.

	check := (ShootoutTreeNode bottomUpTree: 0 depth: stretchDepth) itemCheck.
	output
		nextPutAll: 'stretch tree of depth '; print: stretchDepth; tab;
		nextPutAll: ' check: '; print: check; nl.

	longLivedTree := ShootoutTreeNode bottomUpTree: 0 depth: maxDepth.
	minDepth to: maxDepth by: 2 do: [:depth|
		iterations := 1 bitShift: maxDepth - depth + minDepth.

		check := 0.
		1 to: iterations do: [:i|
			check := check + (ShootoutTreeNode bottomUpTree: i depth: depth) itemCheck.
			check := check + (ShootoutTreeNode bottomUpTree: -1*i depth: depth) itemCheck
			].
		output
			print:  (2*iterations); tab;
			nextPutAll: ' trees of depth '; print: depth; tab;
			nextPutAll: ' check: '; print: check; nl
		].

	output
		nextPutAll: 'long lived tree of depth '; print: maxDepth; tab;
		nextPutAll: ' check: '; print: longLivedTree itemCheck; nl