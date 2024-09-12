; Requires math_vector.xc

; Call a function
; Your new geometry will be placed in $geometry_gen_arr



; ===== Public Vars =====
array $geometry_gen_arr : text



; ===== Functions =====

; Gen Vertices for Square
; Provide side length
function @geometry_gen_square($width:number)
	$geometry_gen_arr.fill(8, "")
	
	$width/=2
	
	$geometry_gen_arr.0 = @vec3_new($width, $width, $width)
	$geometry_gen_arr.1 = @vec3_new(-$width, $width, $width)
	$geometry_gen_arr.2 = @vec3_new($width, -$width, $width)
	$geometry_gen_arr.3 = @vec3_new($width, $width, -$width)
	$geometry_gen_arr.4 = @vec3_new(-$width, -$width, $width)
	$geometry_gen_arr.5 = @vec3_new($width, -$width, -$width)
	$geometry_gen_arr.6 = @vec3_new(-$width, $width, -$width)
	$geometry_gen_arr.7 = @vec3_new(-$width, -$width, -$width)