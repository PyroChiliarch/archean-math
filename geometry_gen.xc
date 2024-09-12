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



function @geometry_gen_smile($size:number)
	$geometry_gen_arr.fill(13, "")
	
	$geometry_gen_arr.0 = @vec3_new($size * 2, $size * 2, 0)
	$geometry_gen_arr.1 = @vec3_new($size * -2, $size * 2, 0)
	$geometry_gen_arr.2 = @vec3_new($size *-3.5, $size * 0, 0)
	$geometry_gen_arr.3 = @vec3_new($size * 3.5, $size * 0, 0)
	$geometry_gen_arr.4 = @vec3_new($size * -3.2, $size * -0.8, 0)
	$geometry_gen_arr.5 = @vec3_new($size * 3.2, $size * -0.8, 0)
	$geometry_gen_arr.6 = @vec3_new($size * -2.5, $size * -1.5, 0)
	$geometry_gen_arr.7 = @vec3_new($size * 2.5, $size * -1.5, 0)
	$geometry_gen_arr.8 = @vec3_new($size * 1.5, $size * -2.1, 0)
	$geometry_gen_arr.9 = @vec3_new($size * -1.5, $size * -2.1, 0)
	$geometry_gen_arr.10 = @vec3_new($size * 0.6, $size * -2.3, 0)
	$geometry_gen_arr.11 = @vec3_new($size * -0.6, $size * -2.3, 0)
	$geometry_gen_arr.12 = @vec3_new($size * 0, $size * -2.4, 0)