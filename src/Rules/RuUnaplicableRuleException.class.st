"
I am here to ensure backward-compatiblity after the renaming of my super-class.

Do not use me.
"
Class {
	#name : #RuUnaplicableRuleException,
	#superclass : #RuUnapplicableRuleError,
	#category : #'Rules-Exceptions'
}

{ #category : #deprecation }
RuUnaplicableRuleException class >> isDeprecated [
	^ true
]
