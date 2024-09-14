; Creates a new PID object
function @math_pid_new ($p:number, $i:number, $d:number): text
	var $pid = ""
	$pid.p = $p
	$pid.i = $i
	$pid.d = $d
	$pid.last_time = 0
	$pid.integral = 0 ; = Total error over time
	$pid.last_error = 0
	$pid.output = 0
	return $pid
	
; Use a PID controller
function @math_pid_update ($pid:text, $curValue:number, $targetValue:number): text
	
	
	; Get Error
	var $error = $targetValue - $curValue
	
	; Get Delta
	var $delta_time = (time - $pid.last_time)
	$pid.last_time = time
	var $delta_error = $error - $pid.last_error
	$pid.last_error = $error
	
	$pid.integral += $error * $delta_time
	var $derivative = $delta_error / $delta_time
	
	$pid.output = ($pid.p * $error) + ($pid.i * $pid.integral) + ($pid.d * $derivative)
	
	return $pid

; Reset PID to original state
function @math_pid_reset ($pid:text): text
	$pid.last_error = 0
	$pid.last_time = 0
	$pid.integral = 0
	return $pid