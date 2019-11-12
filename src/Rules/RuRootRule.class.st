"
Description
-------------------

I am a simple composite rule just holding a model. I should be the root the user can use and all my subrules will use my model to compute their remediation time.

Example
-------------------

	RuRootRule on: aModel	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	model:					<aModel>			The model on which look for violations.
	workingHours:		<anNumber>		The number of working hours to use to deduce technical debt.

"
Class {
	#name : #RuRootRule,
	#superclass : #RuCompositeRule,
	#instVars : [
		'model',
		'workingHours'
	],
	#category : #'Rules-Model'
}

{ #category : #'instance creation' }
RuRootRule class >> labelled: aString explanation: anotherString model: aModel [
	^ (super labelled: aString explanation: anotherString)
		model: aModel;
		yourself
]

{ #category : #initialization }
RuRootRule >> initialize [
	super initialize.
	workingHours := 8
]

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

{ #category : #accessing }
RuRootRule >> workingHours [
	^ workingHours
]

{ #category : #accessing }
RuRootRule >> workingHours: anObject [
	workingHours := anObject
]
