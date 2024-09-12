; 
;	Requires math_vector.xc
;
;
;	Library for 4x4 matrixes
;	Useful for 3d graphics
;
;	A matrix 4x4 array	
;	[ 0, 4, 8,  12 ]
;	[ 1, 5, 9,  13 ]
;	[ 2, 6, 10, 14 ]
;	[ 3, 7, 11, 15 ]
;
;
;
;
;	This library uses 2 Global arrays to work with Matrices:
;	$matrix_arr_0
;	$matrix_arr_1
;	You should call @matrix_reset() in init to initialize them both 
;
;	Most functions will have an argument that lets you choose which global matrix you will modify
;	You should pass a 0 or 1 to select which array you want to modify
;	
;	Example below will print $matrix_arr_1 to the console
;	@matrix_print(1) 
;
;
;
;
;	This is a list of variables and functions
;	Look at the variable/function itself for more details
;
;	===== Global Varibles =====
;
;	Matrix Storage
;	Functions use these
;	$matrix_arr_0
;	$matrix_arr_1
;
;
;	===== Functions =====
;	
;	Helper functions to make you life easier
;	@matrix_reset()
;	@matrix_swap ()
;	@matrix_print ($matrix:number)
;
;	Perform Arithmetic on matrices
;	@matrix_multiply_vector($vec:text):text
;	@matrix_multiply_matrix($out_to:number)
;	
;	Constructors, will the selected matrix and replace it with a new one
;	@matrix_zero ($matrix:number)
;	@matrix_identity ($matrix:number)
;	@matrix_translate ($vec:text, $matrix:number)
;	@matrix_scale ($vec:text, $matrix:number)
;	@matrix_shear ($vec:text, $matrix:number)
;	@matrix_rotate_x ($radians:number, $matrix:number)
;	@matrix_rotate_y ($radians:number, $matrix:number)
;	@matrix_rotate_z ($radians:number, $matrix:number)
;
;
;
;
;	Why is this library/module built this?
;	You cant pass arrays to functions in XenonCode, so the library reuses a couple global arrays
;
;	
;
;	Reference URL to help with understanding Matrices
; 	https://harry7557558.github.io/tools/matrixv.html#
;	https://en.wikipedia.org/wiki/Transformation_matrix
;	http://www.opengl-tutorial.org/beginners-tutorials/tutorial-3-matrices/
;	https://en.wikipedia.org/wiki/File:2D_affine_transformation_matrix.svg
;	https://tinylittlemaggie.github.io/transformation-matrix-playground/
;
;
;	




; =============== Public Vars ===============

; Arrays that the library uses
; You can copy these out to your own arrays to save them
array $matrix_arr_0 : number
array $matrix_arr_1 : number












; =============== Functions ===============





; ===== Helper Functions =====
	


; Init both global arrays
function @matrix_reset ()

	$matrix_arr_0.fill(16, 0)
	$matrix_arr_1.fill(16, 0)





; Swap the global matrices
; $matrix_arr_0 <=> $matrix_arr_1
function @matrix_swap ()
	
	; Create middle man matrix
	array $matrix_temp : number
	
	$matrix_temp.from($matrix_arr_0)
	$matrix_arr_0.from($matrix_arr_1)
	$matrix_arr_1.from($matrix_temp)





; Prints a matrix to the console for troubleshooting
function @matrix_print ($matrix:number)
	if $matrix == 0
		print(text("[	{},	{},	{},	{}	]", $matrix_arr_0.0, $matrix_arr_0.4, $matrix_arr_0.8, $matrix_arr_0.12))
		print(text("[	{},	{},	{},	{}	]", $matrix_arr_0.1, $matrix_arr_0.5, $matrix_arr_0.9, $matrix_arr_0.13))
		print(text("[	{},	{},	{},	{}	]", $matrix_arr_0.2, $matrix_arr_0.6, $matrix_arr_0.10, $matrix_arr_0.14))
		print(text("[	{},	{},	{},	{}	]", $matrix_arr_0.3, $matrix_arr_0.7, $matrix_arr_0.11, $matrix_arr_0.15))
	
	elseif $matrix == 1
		print(text("[	{},	{},	{},	{}	]", $matrix_arr_1.0, $matrix_arr_1.4, $matrix_arr_1.8, $matrix_arr_1.12))
		print(text("[	{},	{},	{},	{}	]", $matrix_arr_1.1, $matrix_arr_1.5, $matrix_arr_1.9, $matrix_arr_1.13))
		print(text("[	{},	{},	{},	{}	]", $matrix_arr_1.2, $matrix_arr_1.6, $matrix_arr_1.10, $matrix_arr_1.14))
		print(text("[	{},	{},	{},	{}	]", $matrix_arr_1.3, $matrix_arr_1.7, $matrix_arr_1.11, $matrix_arr_1.15))
	






	
	












; ===== Matrix Multiplication =====


; Multiple a Matrix and a Vector
; Returns a vector 4
; https://mathinsight.org/matrix_vector_multiplication
function @matrix_multiply_vector($vec:text):text
	
	; Error handling
	
	; $vec is nil
	if $vec == ""
		print("@matrix_multiply_vector received empty string")
		$vec = 0/0
		
	
	; If vector is smaller than 4, increase its size to match matrix
	if $vec.type == 2
		var $new = $vec4_zero
		$new.x = $vec.x
		$new.y = $vec.y
		$vec = $new
	
	if $vec.type == 3
		var $new = $vec4_zero
		$new.x = $vec.x
		$new.y = $vec.y
		$new.z = $vec.z
		$vec = $new
	
	
	; Multiple vector and matrix
	; Result is a Vector (1x4 matrix)
	var $result = $vec4_zero
	$result.x = ($vec.x * $matrix_arr_0.0) + ($vec.y * $matrix_arr_0.4) + ($vec.z * $matrix_arr_0.8) + ($vec.w * $matrix_arr_0.12)
	$result.y = ($vec.x * $matrix_arr_0.1) + ($vec.y * $matrix_arr_0.5) + ($vec.z * $matrix_arr_0.9) + ($vec.w * $matrix_arr_0.13)
	$result.z = ($vec.x * $matrix_arr_0.2) + ($vec.y * $matrix_arr_0.6) + ($vec.z * $matrix_arr_0.10) + ($vec.w * $matrix_arr_0.14)
	$result.w = ($vec.x * $matrix_arr_0.3) + ($vec.y * $matrix_arr_0.7) + ($vec.z * $matrix_arr_0.11) + ($vec.w * $matrix_arr_0.15)
	return $result
	
	







; Multiply both global matricies
; $matrix_arr_1 * $matrix_arr_0
function @matrix_multiply_matrix($out_to:number)
	array $out : number
	$out.fill(16, 0)
	
	; First Row
	$out.0 = ($matrix_arr_1.0 * $matrix_arr_0.0) + ($matrix_arr_1.4 * $matrix_arr_0.1) + ($matrix_arr_1.8 * $matrix_arr_0.2) + ($matrix_arr_1.12 * $matrix_arr_0.3)
	$out.4 = ($matrix_arr_1.0 * $matrix_arr_0.4) + ($matrix_arr_1.4 * $matrix_arr_0.5) + ($matrix_arr_1.8 * $matrix_arr_0.6) + ($matrix_arr_1.12 * $matrix_arr_0.7)
	$out.8 = ($matrix_arr_1.0 * $matrix_arr_0.8) + ($matrix_arr_1.4 * $matrix_arr_0.9) + ($matrix_arr_1.8 * $matrix_arr_0.10) + ($matrix_arr_1.12 * $matrix_arr_0.11)
	$out.12 = ($matrix_arr_1.0 * $matrix_arr_0.12) + ($matrix_arr_1.4 * $matrix_arr_0.13) + ($matrix_arr_1.8 * $matrix_arr_0.14) + ($matrix_arr_1.12 * $matrix_arr_0.15)
	
	; First Second Row
	$out.1 = ($matrix_arr_1.1 * $matrix_arr_0.0) + ($matrix_arr_1.5 * $matrix_arr_0.1) + ($matrix_arr_1.9 * $matrix_arr_0.2) + ($matrix_arr_1.13 * $matrix_arr_0.3)
	$out.5 = ($matrix_arr_1.1 * $matrix_arr_0.4) + ($matrix_arr_1.5 * $matrix_arr_0.5) + ($matrix_arr_1.9 * $matrix_arr_0.6) + ($matrix_arr_1.13 * $matrix_arr_0.7)
	$out.9 = ($matrix_arr_1.1 * $matrix_arr_0.8) + ($matrix_arr_1.5 * $matrix_arr_0.9) + ($matrix_arr_1.9 * $matrix_arr_0.10) + ($matrix_arr_1.13 * $matrix_arr_0.11)
	$out.13 = ($matrix_arr_1.1 * $matrix_arr_0.12) + ($matrix_arr_1.5 * $matrix_arr_0.13) + ($matrix_arr_1.9 * $matrix_arr_0.14) + ($matrix_arr_1.13 * $matrix_arr_0.15)
	
	; Third Row
	$out.2 = ($matrix_arr_1.2 * $matrix_arr_0.0) + ($matrix_arr_1.6 * $matrix_arr_0.1) + ($matrix_arr_1.10 * $matrix_arr_0.2) + ($matrix_arr_1.14 * $matrix_arr_0.3)
	$out.6 = ($matrix_arr_1.2 * $matrix_arr_0.4) + ($matrix_arr_1.6 * $matrix_arr_0.5) + ($matrix_arr_1.10 * $matrix_arr_0.6) + ($matrix_arr_1.14 * $matrix_arr_0.7)
	$out.10 = ($matrix_arr_1.2 * $matrix_arr_0.8) + ($matrix_arr_1.6 * $matrix_arr_0.9) + ($matrix_arr_1.10 * $matrix_arr_0.10) + ($matrix_arr_1.14 * $matrix_arr_0.11)
	$out.14 = ($matrix_arr_1.2 * $matrix_arr_0.12) + ($matrix_arr_1.6 * $matrix_arr_0.13) + ($matrix_arr_1.10 * $matrix_arr_0.14) + ($matrix_arr_1.14 * $matrix_arr_0.15)
	
	; Fourth Row
	$out.3 = ($matrix_arr_1.3 * $matrix_arr_0.0) + ($matrix_arr_1.7 * $matrix_arr_0.1) + ($matrix_arr_1.11 * $matrix_arr_0.2) + ($matrix_arr_1.15 * $matrix_arr_0.3)
	$out.7 = ($matrix_arr_1.3 * $matrix_arr_0.4) + ($matrix_arr_1.7 * $matrix_arr_0.5) + ($matrix_arr_1.11 * $matrix_arr_0.6) + ($matrix_arr_1.15 * $matrix_arr_0.7)
	$out.11 = ($matrix_arr_1.3 * $matrix_arr_0.8) + ($matrix_arr_1.7 * $matrix_arr_0.9) + ($matrix_arr_1.11 * $matrix_arr_0.10) + ($matrix_arr_1.15 * $matrix_arr_0.11)
	$out.15 = ($matrix_arr_1.3 * $matrix_arr_0.12) + ($matrix_arr_1.7 * $matrix_arr_0.13) + ($matrix_arr_1.11 * $matrix_arr_0.14) + ($matrix_arr_1.15 * $matrix_arr_0.15)
	
	
	if $out_to == 0
		$matrix_arr_0.from($out)
	elseif $out_to == 1
		$matrix_arr_1.from($out)













; ===== Matrix Constructors



; Gets a matrix full of 0
; Outputs to $matrix_arr_0
function @matrix_zero ($matrix:number)
	
	; Make an empty matrix
	
	if $matrix == 0
		$matrix_arr_0.fill(16, 0)
	elseif $matrix == 1
		$matrix_arr_1.fill(16, 0)







; Creates an identity matrix
function @matrix_identity ($matrix:number)
	
	; Start with empty matrix
	@matrix_zero($matrix)
	
	if $matrix == 0
		; Change diagonal to 1
		$matrix_arr_0.0 = 1
		$matrix_arr_0.5 = 1
		$matrix_arr_0.10 = 1
		$matrix_arr_0.15 = 1
	elseif $matrix == 1
		; Change diagonal to 1
		$matrix_arr_1.0 = 1
		$matrix_arr_1.5 = 1
		$matrix_arr_1.10 = 1
		$matrix_arr_1.15 = 1
	




; Create a Translation matrix
function @matrix_translate ($vec:text, $matrix:number)
	
	; Start with the identity matrix
	@matrix_identity($matrix)
	
	if $matrix == 0
		; Create a translation matrix
		$matrix_arr_0.12 = $vec.x
		$matrix_arr_0.13 = $vec.y
		$matrix_arr_0.14 = $vec.z
	
	elseif $matrix == 1
		; Create a translation matrix
		$matrix_arr_1.12 = $vec.x
		$matrix_arr_1.13 = $vec.y
		$matrix_arr_1.14 = $vec.z
	
	





; Create a Scale matrix
; use $matrix_arr_0
; Use vec 3
function @matrix_scale ($vec:text, $matrix:number)
	
	; Start with the identity matrix
	@matrix_identity($matrix)
	
	; Create a scale matrix
	if $matrix == 0
		$matrix_arr_0.0 = $vec.x
		$matrix_arr_0.5 = $vec.y
		$matrix_arr_0.10 = $vec.z
	
	elseif $matrix == 1
		$matrix_arr_1.0 = $vec.x
		$matrix_arr_1.5 = $vec.y
		$matrix_arr_1.10 = $vec.z



; Create a shear matrix
function @matrix_shear ($vec:text, $matrix:number)
	
	print("Warning: Shear matrix might be borked, needs testing")
	
	
	; Start with the identity matrix
	@matrix_identity($matrix)
	
	; Create a shear matrix
	if $matrix == 0
		$matrix_arr_0.8 = $vec.x
		$matrix_arr_0.5 = $vec.y
		$matrix_arr_0.2 = $vec.z
	
	elseif $matrix == 1
		$matrix_arr_1.8 = $vec.x
		$matrix_arr_1.5 = $vec.y
		$matrix_arr_1.2 = $vec.z






; Create a rotation matrix

; https://en.wikipedia.org/wiki/Rotation_matrix
; Section "In three dimensions > Basic 3D rotations"
function @matrix_rotate_x ($radians:number, $matrix:number)
	
	; Start with the identity matrix
	@matrix_identity($matrix)
	
	; Create a rotation matrix
	if $matrix == 0
		$matrix_arr_0.5 = cos($radians)
		$matrix_arr_0.9 = -sin($radians)
		$matrix_arr_0.6 = sin($radians)
		$matrix_arr_0.10 = cos($radians)
	
	if $matrix == 1	
		$matrix_arr_1.5 = cos($radians)
		$matrix_arr_1.9 = -sin($radians)
		$matrix_arr_1.6 = sin($radians)
		$matrix_arr_1.10 = cos($radians)

function @matrix_rotate_y ($radians:number, $matrix:number)

	; Start with the identity matrix
	@matrix_identity($matrix)
	
	; Create a rotation matrix
	if $matrix == 0
		$matrix_arr_0.0 = cos($radians)
		$matrix_arr_0.8 = sin($radians)
		$matrix_arr_0.2 = -sin($radians)
		$matrix_arr_0.10 = cos($radians)
		
	if $matrix == 1	
		$matrix_arr_1.0 = cos($radians)
		$matrix_arr_1.8 = -sin($radians)
		$matrix_arr_1.2 = sin($radians)
		$matrix_arr_1.10 = cos($radians)
		
	
function @matrix_rotate_z ($radians:number, $matrix:number)

	; Start with the identity matrix
	@matrix_identity($matrix)

	; Create a rotation matrix
	if $matrix == 0
		$matrix_arr_0.0 = cos($radians)
		$matrix_arr_0.4 = -sin($radians)
		$matrix_arr_0.1 = sin($radians)
		$matrix_arr_0.5 = cos($radians)
		
	if $matrix == 1	
		$matrix_arr_1.0 = cos($radians)
		$matrix_arr_1.4 = -sin($radians)
		$matrix_arr_1.1 = sin($radians)
		$matrix_arr_1.5 = cos($radians)
	