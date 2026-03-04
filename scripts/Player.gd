extends CharacterBody2D

@export var normal_speed: float = 400.0
@export var focus_speed: float = 150.0 # Velocidade lenta para desviar de balas
var current_speed: float = 0.0

func _physics_process(_delta: float) -> void:
	# Verifica se o Shift está pressionado
	if Input.is_action_pressed("ui_focus"): # Você precisará criar essa ação no Input Map
		current_speed = focus_speed
	else:
		current_speed = normal_speed

	# Pega o input (Setas ou WASD)
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = direction * current_speed
	move_and_slide()
