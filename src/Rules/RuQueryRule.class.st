"
Description
--------------------

I am a leaf rule using a query object to find the violations on a model.

The user need to give me a query object and I'll delegate the way to find violations to it.

A query object should be a user of the RuTQuery trait.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	inputQuery:		<aRuTQuery> 		A query object implementing RuTQuery which will have the responsibility to find the violations.

"
Class {
	#name : #RuQueryRule,
	#superclass : #RuLeafRule,
	#instVars : [
		'inputQuery'
	],
	#category : #'Rules-Model'
}

{ #category : #'instance creation' }
RuQueryRule class >> from: aQuery [
	^ self new
		inputQuery: aQuery;
		yourself
]

{ #category : #comparing }
RuQueryRule >> = anObject [
	^ super = anObject and: [ inputQuery = anObject inputQuery ]
]

{ #category : #accessing }
RuQueryRule >> computeViolations [
	^ [ self inputQuery runOn: self model ]
		on: Error
		do: [ :e | RuUnapplicableRuleError signalForRule: self model: self model cachedError: e ]
]

{ #category : #accessing }
RuQueryRule >> explanation [
	^ explanation ifNil: [ self inputQuery explanation ]
]

{ #category : #comparing }
RuQueryRule >> hash [
	^ super hash bitXor: inputQuery hash
]

{ #category : #accessing }
RuQueryRule >> inputQuery [
	^ inputQuery
]

{ #category : #accessing }
RuQueryRule >> inputQuery: anObject [
	inputQuery := anObject.
	self resetCache
]
