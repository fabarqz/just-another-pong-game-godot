extends Node2D

var screen_size
var pad_size
var direction=Vector2(1.0,0.0)

const MIN_ANGLE_DEGREES=30
const MAX_ANGLE_DEGREES=60

const INITIAL_BALL_SPEED=300
var ball_speed=INITIAL_BALL_SPEED
const PAD_SPEED=250

const BALL_SIZE=32
const BALL_RADIUS=BALL_SIZE/2

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size=get_viewport_rect().size
	pad_size=$leftPaddle.get_texture().get_size()
	set_process(true)
	randomize_direction()
	
	
func _process(delta):
	var ball_position=$ball.get_position()
	var left_pad=Rect2($leftPaddle.get_position()-pad_size*0.5,pad_size)
	var right_pad=Rect2($rightPaddle.get_position()-pad_size*0.5,pad_size)


			
	if((ball_position.y-BALL_RADIUS <=0 and direction.y<0) or (ball_position.y+BALL_RADIUS>screen_size.y and direction.y>0)):
		direction.y=-direction.y
		direction=clamp_angle(direction)		
			
	if ball_position.y - BALL_RADIUS <= 0:
		ball_position.y = BALL_RADIUS
	elif ball_position.y + BALL_RADIUS >= screen_size.y:
		ball_position.y =  screen_size.y-BALL_RADIUS 
	
		
	if((left_pad.has_point(ball_position) and direction.x<0) or (right_pad.has_point(ball_position) and direction.x>0)):
		direction.x=-direction.x
		direction.y=randf()*2.0-1
		direction=direction.normalized()
		ball_speed*=1.2

	ball_position+=direction*ball_speed*delta	
	#Check for gameover		
	if (ball_position.x<0 or ball_position.x>screen_size.x):
		ball_position=screen_size*0.5
		ball_speed=INITIAL_BALL_SPEED
		direction=Vector2(-1,0)
		randomize_direction()
		
	$ball.set_position(ball_position)
	
	#Left Paddle Control
	
	var left_paddle_position=$leftPaddle.get_position()
	
	if(left_paddle_position.y>0 and Input.is_action_pressed("player_up")):
		left_paddle_position.y+=-PAD_SPEED*delta
	if(left_paddle_position.y<screen_size.y and Input.is_action_pressed("player_down")):
		left_paddle_position.y+=PAD_SPEED*delta
	
	$leftPaddle.set_position(left_paddle_position)	
		
		
	#Right Paddle Control (Computer)
	var right_position=$rightPaddle.get_position()
	if(ball_position.y<right_position.y and right_position.y>0):
		right_position.y-=PAD_SPEED*delta
	elif(ball_position.y>right_position.y and right_position.y<screen_size.y):	
		right_position.y+=PAD_SPEED*delta
		
	$rightPaddle.set_position(right_position)	
		
func randomize_direction():
	var angle
	while true:
		angle=rand_range(0,2*PI)
		
		if abs(degree_to_radian(90))>0.1 and abs(degree_to_radian(270)-angle)>0.1:
			break
	direction=Vector2(cos(angle),sin(angle)).normalized()
				
func degree_to_radian(degrees):
	return degrees*PI/180.0

func radian_to_degree(radians):
	return radians*180.0/PI

func clamp_angle(direction):
	var angle_degrees=radian_to_degree(direction.angle())
	

	if angle_degrees > 180 - MIN_ANGLE_DEGREES and angle_degrees < 180 + MIN_ANGLE_DEGREES:
		angle_degrees = 180 - MIN_ANGLE_DEGREES
	elif angle_degrees > 180 + MAX_ANGLE_DEGREES and angle_degrees < 360 - MIN_ANGLE_DEGREES:
		angle_degrees = 360 - MIN_ANGLE_DEGREES	
		
	var new_direction=Vector2(cos(degree_to_radian(angle_degrees)),sin(degree_to_radian(angle_degrees))).normalized()
		
	new_direction.x=sign(direction.x)*abs(new_direction.x)
	
	return new_direction