"
Description
-------------------

I am an abstract leaf rule. I know how many time I need to correct a problem but my subclasses should define how to find my violations. From the violations, I can return the time needed to correct the problems of a rule. 

I use a caching system to remember the time I need to correct those problem but the cache should be reset if the way to find the violations change. 

Public API and Key Messages
--------------------
- #remediationDuration 		Return a Duration corresponding to the time to correct one entities breaking the rule.
- #totalRemediationTime 		Return a Duration corresponding to the time to correct all the entities breaking the rule.
		
Example
------------------
	
	See my subclasses

Internal Representation and Key Implementation Points.
------------------

    Instance Variables
	remediationTime:		<anInteger> 				The number of minutes to correct one infraction.
	resultCache:				<anIntegerOrNil>		A cache to save all the entities breaking a rule.


"
Class {
	#name : #RuLeafRule,
	#superclass : #RuAbstractRule,
	#instVars : [
		'resultCache',
		'remediationTime'
	],
	#category : #'Rules-Model'
}

{ #category : #testing }
RuLeafRule class >> isAbstract [
	<ignoreForCoverage>
	^ self = RuLeafRule
]

{ #category : #comparing }
RuLeafRule >> = anObject [
	^ super = anObject
		and: [ self remediationTime = anObject remediationTime ]
]

{ #category : #accessing }
RuLeafRule >> children [
	^ {}
]

{ #category : #accessing }
RuLeafRule >> computeResult [
	^ self subclassResponsibility
]

{ #category : #memento }
RuLeafRule >> createMemento [
	^ self copy
]

{ #category : #comparing }
RuLeafRule >> hash [
	^ super hash bitXor: self remediationTime hash
]

{ #category : #initialization }
RuLeafRule >> initialize [
	super initialize.
	self remediationTime: 30
]

{ #category : #accessing }
RuLeafRule >> remediationDuration [
	^ Duration minutes: self remediationTime
]

{ #category : #accessing }
RuLeafRule >> remediationTime [
	^ remediationTime
]

{ #category : #accessing }
RuLeafRule >> remediationTime: anObject [
	remediationTime := anObject
]

{ #category : #accessing }
RuLeafRule >> remediationTimeInDays [
	^ self remediationTime / self workingHours / 60
]

{ #category : #initialization }
RuLeafRule >> resetCache [
	self resultCache: nil
]

{ #category : #memento }
RuLeafRule >> restoreFromMemento: aMemento [
	self label: aMemento label.
	self remediationTime: aMemento remediationTime
]

{ #category : #accessing }
RuLeafRule >> result [
	^ self resultCache
		ifNil: [ 
			self resultCache: self computeResult.
			self resultCache ]
]

{ #category : #accessing }
RuLeafRule >> resultCache [
	^ resultCache
]

{ #category : #accessing }
RuLeafRule >> resultCache: anObject [
	resultCache := anObject
]

{ #category : #accessing }
RuLeafRule >> totalRemediationTime [
	^ self remediationDuration * self result size
]

{ #category : #accessing }
RuLeafRule >> workingHours [
	^ 8
]