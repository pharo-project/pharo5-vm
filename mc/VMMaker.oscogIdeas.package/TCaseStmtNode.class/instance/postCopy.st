copying
postCopy

	expression := expression copy.
	firsts := firsts copy.
	lasts := lasts copy.
	cases := (cases collect: [ :case | case copy ])