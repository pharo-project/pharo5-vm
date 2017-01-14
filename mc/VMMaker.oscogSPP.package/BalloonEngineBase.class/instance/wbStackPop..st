accessing stack
wbStackPop: nItems

	self wbTopPut: self wbTopGet + nItems.