"
I am here to ensure backward-compatiblity after the renaming of my super-class.

Do not use me.
"
Class {
	#name : #RuRootRule,
	#superclass : #RuRulesManager,
	#category : #'Rules-Model'
}

{ #category : #deprecation }
RuRootRule class >> isDeprecated [
	^ true
]
