extends Node

class PlayMessage:
	var id
	var volume

func _process(delta):
	update()

func _ready():
	song_channel = AudioStreamPlayer.new()
	add_child(song_channel)
	# create the audio channels (8)
	for i in range(CHANNEL_COUNT):
		var player = AudioStreamPlayer.new()
		add_child(player)
		channels.append(player)
	
	# initialize queue for play messages
	for i in range(MAX_PENDING):
		pending_.append(PlayMessage.new())

func playSound(id, volume):
	var i = head_
	
	while i != tail_:
		if pending_[i].id == id:
			pending_[i].volume = max(volume, pending_[i].volume)
			return
		i = (i + 1) % MAX_PENDING
	assert((tail_ + 1) % MAX_PENDING != head_)
	
	pending_[tail_].id = id
	pending_[tail_].volume = volume
	tail_ = (tail_ + 1) % MAX_PENDING

func startSound(resource, channel, volume):
	var player = channels[channel]
	player.stream = resource
	player.volume_db = volume
	player.play()

func findOpenChannel():
	for i in range(channels.size()):
		if not channels[i].playing:
			return i
	return -1

func playSong(id, volume):
	var stream = load_music(id, volume)
	start_song(stream, volume)
	
func start_song(resource, volume):
	song_channel.stream = resource
	song_channel.volume_db = volume
	song_channel.play()
	pass
	
# Specific for Music
func load_music(id, volume):
	var stream: AudioStream = load("res://Audio/Music/%s" % id)
	return stream

func update():
	while head_ != tail_:
		var resource = loadSound(pending_[head_].id)
		var channel = findOpenChannel()
		if channel == -1:
			break  # no free channel, stop
		startSound(resource, channel, pending_[head_].volume)
		head_ = (head_ + 1) % MAX_PENDING

func loadSound(id):
	var stream: AudioStream = load("res://Audio/%s.ogg" % id)
	return stream

var channels: Array[AudioStreamPlayer] = []
var song_channel: AudioStreamPlayer

# size of request queue
const MAX_PENDING = 16
const CHANNEL_COUNT = 8
var pending_: Array[PlayMessage] = []
var song_: PlayMessage 

var head_ = 0
var tail_ = 0
