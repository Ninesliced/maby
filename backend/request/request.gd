extends Node2D

@export var refresh_button: Button


func _ready() -> void:
	%HTTPRequestGetSeed.request_completed.connect(_on_get_seed_completed)
	%HTTPRequestGetLeaderboard.request_completed.connect(_on_get_leaderboard_completed)
	%HTTPRequestGetRank.request_completed.connect(_on_get_rank_completed)
	%HTTPRequestSubmit.request_completed.connect(_on_submit_completed)

func get_seed():
	%HTTPRequestGetSeed.request("https://laby.arkanyota.com/get_seed")

func submit(pseudo="Pseudo", score=0):
	var data_to_send = {
		"pseudo": pseudo,
		"score": score,
		"seed": GameGlobal.rng_seed
	}
	var json = JSON.stringify(data_to_send)
	var headers = ["Content-Type: application/json"]
	%HTTPRequestSubmit.request("https://laby.arkanyota.com/submit", headers, HTTPClient.METHOD_POST, json)

func get_leaderboard():
	refresh_button.disabled = true
	%HTTPRequestGetLeaderboard.request("https://laby.arkanyota.com/leaderboard")

func get_rank(pseudo="Pseudo"):
	%HTTPRequestGetLeaderboard.request("https://laby.arkanyota.com/rank/"+pseudo)

func _on_get_seed_completed(result, response_code, headers, body):
	if response_code != 200:
		return
	var json = JSON.parse_string(body.get_string_from_utf8())
	GameGlobal.rng_seed = json["seed"]
	if get_parent() is MainMenu:
		get_parent().seed_of_the_day = json["seed"]
		%PlaySeedOfTheDay.has_seed_being_received = true

func _on_get_leaderboard_completed(result, response_code, headers, body):
	if response_code != 200:
		return
	var json = JSON.parse_string(body.get_string_from_utf8())
	# GameGlobal.leaderboard = json
	if get_parent() is not MainMenu:
		return
	var leaderboards = get_parent().leaderboards
	for i in range(len(json)):
		var value = json[i]
		leaderboards[i].change_data(value["pseudo"], str(int(value["score"])))
		
	refresh_button.disabled = false


func _on_get_rank_completed(result, response_code, headers, body):
	if response_code == 404:
		var json = JSON.parse_string(body.get_string_from_utf8())
		if json["error"] == 'Pseudo not found':
			return
		return
	if response_code != 200:
		return
	var json = JSON.parse_string(body.get_string_from_utf8())


func _on_submit_completed(result, response_code, headers, body):
	if response_code != 200:
		return
