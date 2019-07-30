Class {
	#name : #VLCLibrary,
	#superclass : #FFILibrary,
	#instVars : [
		'libVLCInstance'
	],
	#category : #'EMM-SoundSystem-Library'
}

{ #category : #initialization }
VLCLibrary class >> reset [ 
	uniqueInstance := nil
]

{ #category : #'media list' }
VLCLibrary >> addMedia: aMedia inMediaList: aMediaList [
	^ self ffiCall: 'bool libvlc_media_list_add_media(void* aMediaList, void* aMedia)'
]

{ #category : #'event manager' }
VLCLibrary >> attachToEventManager: anEventManager forEvent: aTypeOfEvent withCallback: aCallbackMethod andData: dataWeWantToCarryWithTheEvent [
	"
	anEventManager := vlc eventManagerListPlayer: aListPlayer.
	'the list of event type is available here: https://www.videolan.org/developers/vlc/doc/doxygen/html/group__libvlc__event.html#ga7af8cc980d8f13c9c10ed632990ce6ef'
	vlc
		attachToEventManager: anEventManager 
		forEvent: 'libvlc_MediaListPlayerNextItemSet'
		withCallback: aCallbackMethod 
		andData: dataWeWantToCarryWithTheEvent
	"
	
	self
		ffiCall:
			'
	int libvlc_event_attach ( void * anEventManager,
	void aTypeOfEvent,
	void aCallbackMethod,
	void * dataWeWantToCarryWithTheEvent 
)	'
]

{ #category : #'media list player' }
VLCLibrary >> createListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_new(void* libVLCInstance)'
]

{ #category : #'media list' }
VLCLibrary >> createMediaList [
	^ self ffiCall: 'void* libvlc_media_list_new(void* libVLCInstance)'
]

{ #category : #'media player' }
VLCLibrary >> createPlayerForMedia: aVLCMedia [
	"example:
	
	| media player vlc |
	vlc := VLCLibrary uniqueInstance.
	media := vlc mediaFileFromStringPath: '/home/badetitou/Musique/Coda.mp3'.	
	player := vlc createPlayerForMedia: media.
	"

	^ self ffiCall: 'void* libvlc_media_player_new_from_media(void* aVLCMedia);'
]

{ #category : #'media list player' }
VLCLibrary >> eventManagerListPlayer: aListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_event_manager (void* aListPlayer)'
]

{ #category : #initialization }
VLCLibrary >> initialize [
	super initialize.
	libVLCInstance := self initializeVLC
]

{ #category : #initialization }
VLCLibrary >> initializeVLC [
	^ self ffiCall: 'void * libvlc_new();'
]

{ #category : #'media list player' }
VLCLibrary >> isListPlayerPlaying: aListPlayer [
	^ self ffiCall: 'bool libvlc_media_list_player_is_playing (void* aListPlayer)'
]

{ #category : #'media player' }
VLCLibrary >> isMediaPlayerPlaying: aMediaPlayer [
	"
	| vlc media player |
	vlc := VLCLibrary uniqueInstance.
	media := vlc mediaFileFromStringPath: '/home/badetitou/Musique/Coda.mp3'.	
	player := vlc createPlayerForMedia: media.
	vlc isMediaPlayerPlaying: aMediaPlayer
	"
	^ self ffiCall: 'bool libvlc_media_player_is_playing(void* aMediaPlayer);'
]

{ #category : #'accessing platform' }
VLCLibrary >> libraryName [
	^ 'libvlc.so'
]

{ #category : #media }
VLCLibrary >> mediaFileFromStringPath: aStringPath [
	"ex self mediaFileFromStringPath: '/home/badetitou/Musique/Coda.mp3'"
	^ self ffiCall: 'void* libvlc_media_new_path(void* libVLCInstance, String aStringPath);'
]

{ #category : #'media list player' }
VLCLibrary >> nextListPlayer: aListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_next (void* aListPlayer)'
]

{ #category : #'media list player' }
VLCLibrary >> pauseListPlayer: aListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_pause (void* aListPlayer)'
]

{ #category : #'media player' }
VLCLibrary >> pauseMediaPlayer: aMediaPlayer [
	"
	| vlc media player |
	vlc := VLCLibrary uniqueInstance.
	media := vlc mediaFileFromStringPath: '/home/badetitou/Musique/Coda.mp3'.	
	player := vlc createPlayerForMedia: media.
	vlc pauseMediaPlayer: player
	"
	^ self ffiCall: 'void * libvlc_media_player_pause(void* aMediaPlayer);'
]

{ #category : #'media list player' }
VLCLibrary >> playAt: indexMedia listPlayer: aListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_play_item_at_index (void* aListPlayer, int indexMedia)'
]

{ #category : #'media list player' }
VLCLibrary >> playItem: aMedia listPlayer: aListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_play_item (void* aListPlayer, void* aMedia)'
]

{ #category : #'media list player' }
VLCLibrary >> playListPlayer: aListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_play (void* aListPlayer)'
]

{ #category : #'media player' }
VLCLibrary >> playMediaPlayer: aMediaPlayer [
	"
	| vlc media player |
	vlc := VLCLibrary uniqueInstance.
	media := vlc mediaFileFromStringPath: '/home/badetitou/Musique/Coda.mp3'.	
	player := vlc createPlayerForMedia: media.
	vlc playMediaPlayer: player
	"
	^ self ffiCall: 'void * libvlc_media_player_play(void* aMediaPlayer);'
]

{ #category : #'media player' }
VLCLibrary >> positionMediaPlayer: aMediaPlayer [
	"return a value between 0.0 and 1.0"
	^ self ffiCall: 'float libvlc_media_player_get_position(void* aMediaPlayer);'
]

{ #category : #'media player' }
VLCLibrary >> positionMediaPlayer: aMediaPlayer setAt: thePositionAsFloatBetweenOAnd1 [
	"return a value between 0.0 and 1.0"

	^ self ffiCall: 'float libvlc_media_player_set_position(void* aMediaPlayer, float thePositionAsFloatBetweenOAnd1, true);'
]

{ #category : #'media list player' }
VLCLibrary >> previousListPlayer: aListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_previous (void* aListPlayer)'
]

{ #category : #media }
VLCLibrary >> releaseMedia: aMedia [
	"ex self mediaFileFromStringPath: '/home/badetitou/Musique/Coda.mp3'"
	^ self ffiCall: 'void* libvlc_media_release(void* aMedia);'
]

{ #category : #'media player' }
VLCLibrary >> resetMediaPlayer: aMediaPlayer [
	self positionMediaPlayer: aMediaPlayer setAt: 0.0 
]

{ #category : #'media list player' }
VLCLibrary >> setMediaList: aMediaList forListPlayer: aListPlayer [
	^ self ffiCall: 'void* libvlc_media_list_player_set_media_list (void* aListPlayer, void* aMediaList)'
]

{ #category : #'accessing platform' }
VLCLibrary >> unix32ModuleName [
	#('/usr/lib/i386-linux-gnu' '/usr/lib32' '/usr/lib') , ((OSEnvironment current at: 'LD_LIBRARY_PATH' ifAbsent: [ '' ]) substrings: ':')
		do: [ :path | 
			| libraryPath |
			libraryPath := path asFileReference / self libraryName.
			libraryPath exists ifTrue: [ ^ libraryPath fullName ] ].
	self error: 'Cannot locate cairo library. Please check if it installed on your system'
]

{ #category : #'accessing platform' }
VLCLibrary >> unix64ModuleName [
	#('/usr/lib/i386-linux-gnu' '/usr/lib32' '/usr/lib') , ((OSEnvironment current at: 'LD_LIBRARY_PATH' ifAbsent: [ '' ]) substrings: ':')
		do: [ :path | 
			| libraryPath |
			libraryPath := path asFileReference / self libraryName.
			libraryPath exists ifTrue: [ ^ libraryPath fullName ] ].
	self error: 'Cannot locate cairo library. Please check if it installed on your system'
]

{ #category : #'accessing platform' }
VLCLibrary >> unixModuleName [
	"Kept for backward compatibility. 
	 Users should use unix32* or unix64*"
	^ self unix64ModuleName
]