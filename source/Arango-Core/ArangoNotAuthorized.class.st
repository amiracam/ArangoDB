Class {
	#name : #ArangoNotAuthorized,
	#superclass : #ArangoAPIError,
	#category : #'Arango-Core-Exceptions'
}

{ #category : #'api-errors' }
ArangoNotAuthorized class >> errorNumber [
	^11
]
