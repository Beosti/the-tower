extends Entity

var click_position = Vector2()
var target_position = Vector2()

var npcInRange = [];
var hostileInRange = [];
var target = null;

var talking = false;
var attacking = false;
@export var attack_speed = 3.0;
func _ready():
	_set_speed(100);
	_set_health(5);
	$Timer.start();
	$Timer.wait_time = attack_speed;
	$Timer.one_shot = true;
	click_position = position

func _physics_process(delta):
	_handle_dialogue();
	_handle_attack();
	_handle_movement();
func _handle_movement():
	if (attacking && !Input.is_action_just_pressed("right_click")):
		return;
	elif (talking && !Input.is_action_just_pressed("right_click")):
		return;
	if Input.is_action_just_pressed("right_click"):
		for npc in npcInRange:
			if !(npc.clickable == true):
				continue;
			if !(Input.is_action_just_pressed("shift_press")):
				return;
		for hostile in hostileInRange:
			if !(hostile.clickable == true):
				continue;
			if !(Input.is_action_just_pressed("shift_press")):
				return;
		click_position = get_global_mouse_position()
	if position.distance_to(click_position) > 3:
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		move_and_slide()
func _handle_attack():
	if Input.is_action_just_pressed("right_click") && !Input.is_action_just_pressed("shift_press"):
		for hostile in hostileInRange:
			if (!hostile.clickable == true):
				continue;
			target = hostile;
			attacking = true;
			return;
	if !$Timer.is_stopped():
		return;
	if !target == null:
		print("attack");
	$Timer.start();
func _handle_dialogue():
	if Input.is_action_just_pressed("right_click") && !Input.is_action_pressed("shift_press"):
		for npc in npcInRange:
			if !(npc.clickable == true):
				continue;
			DialogueManager.show_example_dialogue_balloon(load(npc.dialogueLocation), "start");
			talking = true;
			return;
func body_entered_talking_range(body):
	if body is NPCEntity:
		npcInRange.append(body);
func body_exited_talking_range(body):
	if body is NPCEntity:
		npcInRange.erase(body);
func body_entered_attack_range(body):
	if (body is HostileEntity):
		hostileInRange.append(body);
func body_exited_attack_range(body):
	if (body is HostileEntity):
		hostileInRange.erase(body);
	if (body == target):
		target = null;
		attacking = false;
