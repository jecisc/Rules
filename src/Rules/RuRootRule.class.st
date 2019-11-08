"
Description
-------------------

I am a simple composite rule just holding a model. I should be the root the user can use and all my subrules will use my model to compute their remediation time.

Example
-------------------

	RuRootRule on: aModel
"
Class {
	#name : #RuRootRule,
	#superclass : #RuCompositeRule,
	#instVars : [
		'model'
	],
	#category : #'Rules-Model'
}

{ #category : #convenience }
RuRootRule >> listAllRules [
	^ self allChildren
]

{ #category : #accessing }
RuRootRule >> model [
	^ model
]

{ #category : #accessing }
RuRootRule >> model: aModel [
	self model = aModel ifTrue: [ ^ self ].

	model := aModel.
	self resetCache
]
