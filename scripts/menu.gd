extends Control

@onready var sprite = $CharacterBody2D

var velocity := Vector2(0, 0)
signal arrived
var moving := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	sprite.velocity = velocity * delta
	sprite.move_and_slide()
	if velocity.x != 0: moving = true
	if moving and (sprite.position.x >= size.x or sprite.position.x <= 0):
		arrived.emit()
		moving = false
		velocity = Vector2(0, 0)
	pass


func move_in():
	velocity = Vector2(70000, 0)
	await arrived
	sprite.position.x = 280
	#while sprite.position.x < size.x:
	
	#Menu.position.x += Menu.size.x if Menu.position.x < Menu.size.x else -Menu.size.x
	pass


func move_out():
	velocity = Vector2(-70000, 0)
	await arrived
	sprite.position.x = 0
	pass
