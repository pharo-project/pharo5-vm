object access
formatOf: oop
"       0      no fields
        1      fixed fields only (all containing pointers)
        2      indexable fields only (all containing pointers)
        3      both fixed and indexable fields (all containing pointers)
        4      both fixed and indexable weak fields (all containing pointers).

        5      unused (reserved for ephemerons?)
        6      indexable word fields only (no pointers)
        7      indexable long (64-bit) fields (only in 64-bit images)
 
    8-11      indexable byte fields only (no pointers) (low 2 bits are low 2 bits of size)
   12-15     compiled methods:
                   # of literal oops specified in method header,
                   followed by indexable bytes (same interpretation of low 2 bits as above)
"
	<inline: true>
	^((self baseHeader: oop) >> self instFormatFieldLSB) bitAnd: 16rF