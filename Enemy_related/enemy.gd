extends CharacterBody2D

@export var player_reference : CharacterBody2D
var direction : Vector2
var speed : float = 80
var damage : float 
var knockback : Vector2
var separation : float
var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://Shaders/Rainbow.tres")
			scale = Vector2(0.4,0.4)

var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage

#for optimization eli ei laga noobeille
func _physics_process(delta: float) -> void:
	check_separation(delta)
	knockback_update(delta)

	
func check_separation(_delta):
	separation = (player_reference.position - position).length()
	if separation >= 1500 and not elite:
		queue_free()
		
		
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self
		
		
		

	
	
func knockback_update(delta):
	velocity = (player_reference.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1) 
	velocity += knockback
	var collider = move_and_collide(velocity * delta)
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50
	
	
	
	
