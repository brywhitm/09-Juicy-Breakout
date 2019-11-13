extends Node2D


onready var t=$Timer

func Shatter():
	$ShatterEffect.emitting=true
	$ShatterEffect2.emitting=true
	$ShatterEffect3.emitting=true
	$ShatterEffect4.emitting=true
	Reset()
	
func Reset():
	var reset=get_parent()
	reset.Stop()
func Stop():
	var time=0.05
	t.set_wait_time(time)
	t.start()
	yield(t,"timeout")
	if time>0.018:
		$ShatterEffect.emitting=false
		$ShatterEffect2.emitting=false
		$ShatterEffect3.emitting=false
		$ShatterEffect4.emitting=false
		time=0