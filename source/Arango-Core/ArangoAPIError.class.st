Class {
	#name : #ArangoAPIError,
	#superclass : #ArangoError,
	#instVars : [
		'request',
		'response'
	],
	#category : #'Arango-Core-Exceptions'
}

{ #category : #'as yet unclassified' }
ArangoAPIError class >> fromDictionary: aDictionary [ 
	^ (self withErrorNumber: (aDictionary at: 'errorNum'))
		initializeFromResponse: aDictionary
]

{ #category : #'as yet unclassified' }
ArangoAPIError class >> fromResponse: aResponse [ 
	^ self fromDictionary: (NeoJSONReader fromString: aResponse contents)

]

{ #category : #'as yet unclassified' }
ArangoAPIError class >> withErrorNumber: anInteger [
	^ (self allSubclasses 
		detect: [ :each | each errorNumber = anInteger ]
		ifNone: [ ArangoAPIErrorNotFound signal: 'no error found for number ', anInteger asString ])
			new
]

{ #category : #initialization }
ArangoAPIError >> initializeFromResponse: aDictionary [ 
	messageText := aDictionary at: 'errorMessage'
]

{ #category : #accessing }
ArangoAPIError >> request: aRequest [ 
	request := aRequest 
]

{ #category : #accessing }
ArangoAPIError >> response: aResponse [ 
	response := aResponse
]
