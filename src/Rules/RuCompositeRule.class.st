"
Description
-------------------

I am a composite rule implementing the Composite design pattern. 

I hold a collection of rules and I also can be part of a composite rule. 

Public API and Key Messages
-------------------

- #children 						Return my children on one level only
- #allChildren 					Return my children and their children in a flat collection
- #totalRemediationTime 		Return a duration to correct *all* my children. 
- #technicalDebt				Return my technicalDebt excluding some rule the user does not want
				 
Internal Representation and Key Implementation Points.
-------------------

    Instance Variables
	children:		<aCollection>	The collection of all my rules

"
Class {
	#name : #RuCompositeRule,
	#superclass : #RuAbstractRule,
	#instVars : [
		'children'
	],
	#category : #'Rules-Model'
}

{ #category : #comparing }
RuCompositeRule >> = anObject [
	^ super = anObject and: [ self children = anObject children ]
]

{ #category : #adding }
RuCompositeRule >> addRule: aRule [
	aRule parent: self.
	^ self children add: aRule
]

{ #category : #accessing }
RuCompositeRule >> allChildren [
	^ self children , (self children flatCollect: #children)
]

{ #category : #accessing }
RuCompositeRule >> children [
	^ children
]

{ #category : #accessing }
RuCompositeRule >> children: anObject [
	children := anObject
]

{ #category : #comparing }
RuCompositeRule >> hash [
	^ super hash bitXor: self children hash
]

{ #category : #initialization }
RuCompositeRule >> initialize [
	super initialize.
	children := OrderedCollection new
]

{ #category : #copying }
RuCompositeRule >> postCopy [
	self children: self children copy
]

{ #category : #removing }
RuCompositeRule >> removeRule: aRule [
	self children remove: aRule ifAbsent: [ "Do nothing" ]
]

{ #category : #initialization }
RuCompositeRule >> resetCache [
	self children do: #resetCache
]

{ #category : #accessing }
RuCompositeRule >> technicalDebt [
	self flag: #todo.	"In the futur we should be able to exclude some rules from the calcul"
	^ self totalRemediationTime
]

{ #category : #accessing }
RuCompositeRule >> totalRemediationTime [
	^ self children inject: Duration zero into: [ :sum :child | sum + child totalRemediationTime ]
]

{ #category : #accessing }
RuCompositeRule >> violations [
	^ self children
		inject: Set new
		into: [ :set :each | 
			set
				addAll: each violations;
				yourself ]
]
