"
Description
-------------------

I am an abstract class to manage a simple rule system. 
A rule system should be able to calculate how much time a user need to correct a list of infractions in a model. 

I implement the composite design pattern. I will have concretes rules for an infraction and also composites rules to manage them. 

The model is currently held by a root rule (that is a composite rule) and all subrules will compute their correction time by asking to their parent the model to check.
 
Internal Representation and Key Implementation Points.
------------------

    Instance Variables
	explanation:			<aString>					A string explaining to the user what the rule search for.
	label:					<aString>					A label representing a the rule.
	parent:				<aCompositeRule>		A composite rule holding me.

"
Class {
	#name : #RuAbstractRule,
	#superclass : #Object,
	#instVars : [
		'label',
		'explanation',
		'parent'
	],
	#category : #'Rules-Model'
}

{ #category : #testing }
RuAbstractRule class >> isAbstract [
	<ignoreForCoverage>
	^ true
]

{ #category : #'instance creation' }
RuAbstractRule class >> parent: aRule [
	^ self new
		parent: aRule;
		yourself
]

{ #category : #comparing }
RuAbstractRule >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ explanation = anObject explanation and: [ label = anObject label ]
]

{ #category : #memento }
RuAbstractRule >> createMemento [
	^ self copy
]

{ #category : #accessing }
RuAbstractRule >> explanation [
	^ explanation
]

{ #category : #accessing }
RuAbstractRule >> explanation: anObject [
	explanation := anObject
]

{ #category : #comparing }
RuAbstractRule >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ explanation hash bitXor: label hash
]

{ #category : #accessing }
RuAbstractRule >> label [
	^ label
]

{ #category : #accessing }
RuAbstractRule >> label: anObject [
	label := anObject
]

{ #category : #accessing }
RuAbstractRule >> model [
	^ self parent model
]

{ #category : #accessing }
RuAbstractRule >> parent [
	^ parent
]

{ #category : #accessing }
RuAbstractRule >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
RuAbstractRule >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $[;
		<< (self label ifNil: [ 'No label' ]);
		<< $]
]

{ #category : #initialization }
RuAbstractRule >> resetCache [
	self subclassResponsibility
]

{ #category : #memento }
RuAbstractRule >> restoreFromMemento: aMemento [
	self label: aMemento label
]

{ #category : #accessing }
RuAbstractRule >> totalRemediationTime [
	^ self subclassResponsibility
]

{ #category : #accessing }
RuAbstractRule >> workingHours [
	^ self parent workingHours
]
