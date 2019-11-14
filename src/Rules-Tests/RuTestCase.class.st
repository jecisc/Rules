Class {
	#name : #RuTestCase,
	#superclass : #TestCase,
	#category : #'Rules-Tests'
}

{ #category : #testing }
RuTestCase class >> isAbstract [
	^ self = RuTestCase
]

{ #category : #testing }
RuTestCase class >> shouldInheritSelectors [
	^ true
]

{ #category : #helpers }
RuTestCase >> addSomeRulesTo: aRule [
	"3 violations"
	self
		query: 'Long Containers'
		meaning: 'Containers should not be longer than 6 lines of code'
		as: [ :aModel | aModel allContainers select: [ :each | each numberOfLinesOfCode > 6 ] ]
		remediationTime: 5 minutes
		for: aRule.
	"0 violations"
	self
		query: 'Complexity of Functions'
		meaning: 'Containers should not be complex: average cyclomatic complexity of more than 10'
		as: [ :aModel | aModel allContainers select: [ :each | each averageCyclomaticComplexity > 10 ] ]
		remediationTime: 10 minutes
		for: aRule.
	"2 violations"
	self
		query: 'Duplicate Containers'
		meaning: 'Containers should not have duplicate code'
		as: [ :aModel | aModel allContainers select: #hasDuplicatedCode ]
		remediationTime: 15 minutes
		for: aRule.
	"1 violations"
	self
		query: 'Dead Containers'
		meaning: 'Containers should not be dead (i.e. not invoked in the system)'
		as: [ :aModel | aModel allContainers select: #containsDeadEntities ]
		remediationTime: 20 minutes
		for: aRule
]

{ #category : #helpers }
RuTestCase >> mockModel [
	| model container1 container2 container3 entity1 |
	container1 := Mock named: 'Container1'.
	container1 stub name willReturn: 'Class1'.
	container1 stub numberOfLinesOfCode willReturn: 24.
	container1 stub hasDuplicatedCode willReturn: true.
	container1 stub containsDeadEntities willReturn: true.
	container1 stub averageCyclomaticComplexity willReturn: 2. 
	container2 := Mock named: 'Container2'.
	container2 stub name willReturn: 'Class2'.
	container2 stub numberOfLinesOfCode willReturn: 11.
	container2 stub hasDuplicatedCode willReturn: false.
	container2 stub containsDeadEntities willReturn: false.
	container2 stub averageCyclomaticComplexity willReturn: 4.
	container3 := Mock named: 'Container3'.
	container3 stub name willReturn: 'Class3'.
	container3 stub numberOfLinesOfCode willReturn: 7.
	container3 stub hasDuplicatedCode willReturn: true.
	container3 stub containsDeadEntities willReturn: false.
	container3 stub averageCyclomaticComplexity willReturn: 1.
	entity1 := Mock named: 'Entity1'.
	entity1 stub name willReturn: 'Method1'.
	model := Mock named: 'Model'.
	model stub allContainers willReturn: {container1 . container2 . container3}.
	model stub entities willReturn: { container1 . container2. container3. entity1 }.
	^ model
]

{ #category : #helpers }
RuTestCase >> query: aLabelString meaning: aMeaningString as: aBlock remediationTime: time for: parent [
	^ parent
		addRule:
			(RuRule
				rule: aBlock
				label: aLabelString
				explanation: aMeaningString
				remediationTime: time)
]

{ #category : #helpers }
RuTestCase >> rootRule [
	^ RuRulesManager labelled: 'Root rule' explanation: 'Test' model: self mockModel
]
