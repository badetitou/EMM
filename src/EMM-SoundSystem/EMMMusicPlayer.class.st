"
This player is a lot inspired by the QueueSound

But it allows us to keep information of the previous sounds
"
Class {
	#name : #EMMMusicPlayer,
	#superclass : #AbstractSound,
	#instVars : [
		'musicList',
		'pointerCurrentMusic',
		'done',
		'startTime'
	],
	#category : #'EMM-SoundSystem'
}

{ #category : #accessing }
EMMMusicPlayer >> add: aPlayable [
	self addAtTheEnd: aPlayable
]

{ #category : #accessing }
EMMMusicPlayer >> addAtTheBeginning: aPlayable [
	musicList addFirst: aPlayable
]

{ #category : #accessing }
EMMMusicPlayer >> addAtTheEnd: aPlayable [
	musicList addLast: aPlayable
]

{ #category : #accessing }
EMMMusicPlayer >> currentSound [ 
	^ (self musicList at: (self pointerCurrentMusic) ifAbsent: [ ^ nil ]) streaming
]

{ #category : #'sound generation' }
EMMMusicPlayer >> doControl [
	super doControl.
	self currentSound notNil ifTrue: [self currentSound doControl]
]

{ #category : #accessing }
EMMMusicPlayer >> done: aBoolean [
	done := aBoolean
]

{ #category : #initialization }
EMMMusicPlayer >> initialize [
	super initialize.
	musicList := OrderedCollection new.
	done := false.
	startTime := Time millisecondClockValue.
	pointerCurrentMusic := 1.
]

{ #category : #'sound generation' }
EMMMusicPlayer >> mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol [
	"Play a collection of sounds in sequence."

	| finalIndex i remaining count rate |
	self currentSound isNil ifTrue: [^ self].  "already done"
	self startTime > Time millisecondClockValue ifTrue: [^ self].
	rate := self samplingRate.
	finalIndex := (startIndex + n) - 1.
	i := startIndex.
	[i <= finalIndex] whileTrue: [
		[self currentSound isNil ifTrue: [^ self].
		(remaining := self currentSound samplesRemaining) <= 0]
			whileTrue: [self nextSound].
		count := (finalIndex - i) + 1.
		remaining < count ifTrue: [count := remaining].
		self currentSound playSampleCount: count into: aSoundBuffer startingAt: i "leftVol: leftVol rightVol: rightVol".
		i := i + count]
]

{ #category : #accessing }
EMMMusicPlayer >> musicList [
	^ musicList
]

{ #category : #accessing }
EMMMusicPlayer >> musicList: aListOfPlayable [
	"set the new list of music and play the musics from the first one"
	musicList := aListOfPlayable.
	pointerCurrentMusic := 1.
	self reset.
	self play
]

{ #category : #control }
EMMMusicPlayer >> nextSound [
	| answer |
	pointerCurrentMusic := pointerCurrentMusic + 1.
	answer := (musicList at: pointerCurrentMusic ifAbsent: [ ^ nil ]) streaming.
	answer reset.
	^ answer
]

{ #category : #accessing }
EMMMusicPlayer >> pointerCurrentMusic [
	^ pointerCurrentMusic 
]

{ #category : #accessing }
EMMMusicPlayer >> pointerCurrentMusic: position [
	self currentSound ifNotNil: [ :currentSound | currentSound reset ].
	pointerCurrentMusic := position
	
]

{ #category : #control }
EMMMusicPlayer >> previousSound [
	| answer |
	pointerCurrentMusic := pointerCurrentMusic - 1.
	answer := (musicList at: pointerCurrentMusic ifAbsent: [ ^ nil ]) streaming.
	answer reset.
	^ answer
]

{ #category : #'sound generation' }
EMMMusicPlayer >> samplesRemaining [
	(done and: [self musicList isEmpty])
		ifTrue: [^ 0]
		ifFalse: [^ 1000000].

]

{ #category : #accessing }
EMMMusicPlayer >> startTime [
	^ startTime
]

{ #category : #accessing }
EMMMusicPlayer >> startTime: anObject [
	startTime := anObject
]