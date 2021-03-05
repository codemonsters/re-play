extends KinematicBody

var gravity = Vector3.DOWN * 10
var baseSpeed = 4
var speed = baseSpeed
var jumpSpeed = 6
var spin = 0.1

var bodiesInGrabArea = []
var bodyGrabbing = Node
var grabbing = false
var getGrab = [Node, Vector3(), false]

var velocity = Vector3()
var airVelocity = Vector3()
var jump = false
var standingOnFloor = false
var collisionVelocity = Vector3()
var movementVelocity = Vector3()

func getInput():
	movementVelocity.x = 0
	movementVelocity.z = 0
	if Input.is_action_pressed("w"):
		movementVelocity += -transform.basis.z * speed
	if Input.is_action_pressed("s"):
		movementVelocity += transform.basis.z * speed
	if Input.is_action_pressed("a"):
		movementVelocity += -transform.basis.x * speed
	if Input.is_action_pressed("d"):
		movementVelocity += transform.basis.x * speed
	if not standingOnFloor:
		movementVelocity.x = airVelocity.x + movementVelocity.x
		movementVelocity.z = airVelocity.z + movementVelocity.z
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true
	if Input.is_action_just_pressed("grab"):
		getGrab = grabBody(bodiesInGrabArea)
		bodyGrabbing = getGrab[0]
		grabbing = getGrab[1]
	if Input.is_action_just_released("grab"):
		grabbing = false
		bodiesInGrabArea = releaseBody(bodiesInGrabArea, bodyGrabbing)

func grabBody(listOfBodies):
	if listOfBodies.size() > 1:
		var bodyGrabbing = listOfBodies[1]
		self.get_node("Pos").global_transform.origin = (2 * bodyGrabbing.global_transform.origin) - self.global_transform.origin
		return [bodyGrabbing, true]
	else:
		return [Node, false]

func releaseBody(listOfBodies, bodyGrabbing):
	if grabbing:
		listOfBodies.remove(listOfBodies.find(bodyGrabbing))
	return listOfBodies

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.relative.x > 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))
		elif event.relative.x < 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))

func _physics_process(delta):
	standingOnFloor = is_on_floor()
	movementVelocity += gravity * delta
	velocity = movementVelocity + collisionVelocity
	collisionVelocity.x = lerp(collisionVelocity.x, 0, 1)
	collisionVelocity.y = lerp(collisionVelocity.y, 0, 1)
	collisionVelocity.z = lerp(collisionVelocity.z, 0, 1)
	getInput()
	#velocity = move_and_slide(velocity, Vector3.UP)
	velocity = move_and_slide(velocity, Vector3.UP, false, 4, 0.785398, false)
	#move_and_collide(velocity)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse((-collision.normal * 0.5) * collision.collider.get_linear_velocity().length())
			collisionVelocity = (collision.normal * collision.collider.mass) * collision.collider.get_linear_velocity().length()
	if jump and standingOnFloor:
		movementVelocity.y = jumpSpeed
		airVelocity = movementVelocity
	if not standingOnFloor:
		speed = baseSpeed * 1.25
	else:
		speed = baseSpeed
	if global_transform.origin.y <= -10:
		global_transform.origin.x = 0
		global_transform.origin.y = 1.25
		global_transform.origin.z = 0
	if grabbing:
		bodyGrabbing.global_transform.origin = (self.global_transform.origin + self.get_node("Pos").global_transform.origin) / 2
		bodyGrabbing.set_rotation(self.get_rotation())

func _on_GrabArea_body_entered(body):
	bodiesInGrabArea.append(body)

func _on_GrabArea_body_exited(body):
	bodiesInGrabArea.remove(bodiesInGrabArea.find(body))
