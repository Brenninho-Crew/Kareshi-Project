extends CharacterBody2D

# Configurações do Inimigo
@export var health: int = 5
@export var speed: float = 100.0
@export var score_value: int = 100

# Referência da Bala (Arraste sua cena de bala para cá no Inspetor)
@export var bullet_scene: PackedScene

# Variáveis de Controle
var direction: Vector2 = Vector2.DOWN
var fire_timer: float = 0.0
@export var fire_rate: float = 1.5 # Atira a cada 1.5 segundos

func _physics_process(delta: float) -> void:
	# Movimentação simples para baixo
	velocity = direction * speed
	move_and_slide()
	
	# Lógica de tiro
	fire_timer += delta
	if fire_timer >= fire_rate:
		shoot_at_player()
		fire_timer = 0.0

	# Deleta o inimigo se ele sair muito da tela (ajuste os valores conforme sua resolução)
	if global_position.y > 700:
		queue_free()

func shoot_at_player():
	if bullet_scene == null: return
	
	# Cria a bala
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	
	# Lógica básica para mirar no player (opcional)
	# Se quiser que ele atire reto para baixo:
	bullet.direction = Vector2.DOWN
	
	# Adiciona a bala ao BulletManager da Main
	var manager = get_tree().root.find_child("BulletManager", true, false)
	if manager:
		manager.add_child(bullet)

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	# Aqui você pode adicionar efeitos de explosão ou som
	print("Inimigo derrotado!")
	queue_free()