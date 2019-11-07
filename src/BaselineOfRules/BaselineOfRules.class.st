"
Description
--------------------

I am a baseline to configure the Rules project.

https://github.com/jecisc/Rules
"
Class {
	#name : #BaselineOfRules,
	#superclass : #BaselineOf,
	#category : #BaselineOfRules
}

{ #category : #baselines }
BaselineOfRules >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Dependencies"
			self mocketry: spec.
			
			"Packages"
			spec
				package: 'Rules';
				package: 'Rules-Tests' with: [ spec requires: #('Rules' 'Mocketry') ].
			
			"Groups"
			spec
				group: 'Core' with: #('Rules');
				group: 'Tests' with: #('Rules-Tests') ]
]

{ #category : #dependencies }
BaselineOfRules >> mocketry: spec [
	spec
		baseline: 'Mocketry'
		with: [ spec
				loads: #('Core');
				repository: 'github://dionisiydk/Mocketry:v6.0.x' ]
]
