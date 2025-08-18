extends Control

@onready var skill_icon: TextureRect = %SkillIcon
@export var disabled_color: Color = Color(0.5, 0.5, 0.5, 1)

@onready var button: Button = %Button
@onready var cooldown_label: Label = %CooldownLabel

func _ready() -> void:
	if !GameGlobal.player:
		await GameGlobal.player_ready
	var player: Player = GameGlobal.player
	var skill = player.skill_component.skill
	var skill_component: SkillComponent = player.skill_component
	skill_component.on_skill_cooldown_changed.connect(_on_cooldown)
	skill_component.on_skill_ready.connect(enable)
	set_icon(skill.icon)

func set_icon(icon: Texture2D) -> void:
	skill_icon.texture = icon

func _on_button_pressed() -> void:
	var player: Player = GameGlobal.player
	if !player:
		return
	player.skill_component.use_skill()
	pass # Replace with function body.

func _on_cooldown(cooldown: int) -> void:
	cooldown_label.text = str(cooldown)
	disable()

func disable():
	button.modulate = disabled_color

func enable():
	cooldown_label.text = ""
	button.modulate = Color(1, 1, 1, 1)
