Class {
	#name : #RuMockNameQuery,
	#superclass : #Object,
	#traits : 'RuTQuery',
	#classTraits : 'RuTQuery classTrait',
	#instVars : [
		'regex'
	],
	#category : #'Rules-Tests'
}

{ #category : #'instance creation' }
RuMockNameQuery class >> regex: aRegex [
	^ self new
		regex: aRegex;
		yourself
]

{ #category : #comparing }
RuMockNameQuery >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ regex = anObject regex
]

{ #category : #'as yet unclassified' }
RuMockNameQuery >> explanataion [
	^ 'I am a mock query'
]

{ #category : #comparing }
RuMockNameQuery >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ regex hash
]

{ #category : #accessing }
RuMockNameQuery >> regex [
	^ regex
]

{ #category : #accessing }
RuMockNameQuery >> regex: anObject [
	regex := anObject
]

{ #category : #running }
RuMockNameQuery >> runOn: aModel [
	^ aModel entities select: [ :item | regex asRegex matches: item name ]
]
