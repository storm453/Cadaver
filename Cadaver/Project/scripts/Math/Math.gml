#macro PI 3.14159265358979

function fract(x) 
{
  return x - floor(x);
}
function rand(cox, coy)
{
    return fract(sin(cox * 12.9898 + coy * 78.233) * 43758.5453);
}

function get_delta_time() {
	return delta_time / 1000000;
}

////////

function msin(x) {
	return sin(x / 180 * PI);
}

function mcos(x) {
	return cos(x / 180 * PI);
}

function mtan(x) {
	return tan(x / 180 * PI);
}

function v2(x, y) {
	if (y == undefined)
		y = x;
	return {
		x: x,
		y: y
	};
}

function v2_add(a, b) {
    return {
        x: a.x + b.x,
        y: a.y + b.y
    };
}

function v2_sub(a, b) {
    return {
        x: a.x - b.x,
        y: a.y - b.y
    };
}

function v2_mul(a, b) {
    return {
        x: a.x * b.x,
        y: a.y * b.y
    };
}

function v2_div(a, b) {
    return {
        x: a.x / b.x,
        y: a.y / b.y
    };
}


function v2_dot(a, b) {
    return a.x * b.x + a.y * b.y;
}


function v2_length(a) {
    return sqrt(a.x * a.x + a.y * a.y);
}


function v2_distance(a, b) {
    return v2_length(v2_sub(a, b));
}

function v2_manhat_distance(a, b) {
    var v = v2_sub(a, b);
    return abs(v.x) + abs(v.y);
}


function v2_normalized(a) {
	var l = v2_length(a);
	if (l == 0) l = 1;
	return v2_div(a, v2(l));
}


////////

function v3(x, y, z) {
	if (y == undefined)
		y = x;
	if (z == undefined)
		z = x;
	return {
		x: x,
		y: y,
		z: z,
	};
}

function v3_add(a, b) {
    return {
        x: a.x + b.x,
        y: a.y + b.y,
		z: a.z + b.z
    };
}

function v3_sub(a, b) {
    return {
        x: a.x - b.x,
        y: a.y - b.y,
		z: a.z - b.z,
    };
}

function v3_mul(a, b) {
    return {
        x: a.x * b.x,
        y: a.y * b.y,
		z: a.z * b.z,
    };
}

function v3_div(a, b) {
    return {
        x: a.x / b.x,
        y: a.y / b.y,
		z: a.z / b.z,
    };
}


function v3_dot(a, b) {
    return a.x * b.x + a.y * b.y + a.z * b.z;
}


function v3_length(a) {
    return sqrt(a.x * a.x + a.y * a.y + a.z * a.z);
}


function v3_distance(a, b) {
    return v3_length(v3_sub(a, b));
}

function v3_normalized(a) {
	var l = v3_length(a);
	if (l == 0) l = 1;
	return v3_div(a, v3(l));
}

////////


function v4(x, y, z, w) {
	if (y == undefined)
		y = x;
	if (z == undefined)
		z = x;
	if (w == undefined)
		w = x;
	return {
		x: x,
		y: y,
		z: z,
		w: w,
	};
}

function v4_add(a, b) {
    return {
        x: a.x + b.x,
        y: a.y + b.y,
		z: a.z + b.z,
		w: a.w + b.w,
    };
}

function v4_sub(a, b) {
    return {
        x: a.x - b.x,
        y: a.y - b.y,
		z: a.z - b.z,
		w: a.w - b.w,
    };
}

function v4_mul(a, b) {
    return {
        x: a.x * b.x,
        y: a.y * b.y,
		z: a.z * b.z,
		w: a.w * b.w,
    };
}

function v4_div(a, b) {
    return {
        x: a.x / b.x,
        y: a.y / b.y,
		z: a.z / b.z,
		w: a.w / b.w,
    };
}


function v4_dot(a, b) {
    return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
}

function v4_length(a) {
    return sqrt(a.x * a.x + a.y * a.y + a.z * a.z + a.w * b.w);
}


function v4_distance(a, b) {
    return v4_length(v4_sub(a, b));
}

function v4_normalized(a) {
	var l = v4_length(a);
	if (l == 0) l = 1;
	return v4_div(a, v4(l));
}

////////

function m4(trace) {
	var arr = array_create(16);

	arr[0] = trace;
	arr[1] = 0;
	arr[2] = 0;
	arr[3] = 0;

	arr[4] = 0;
	arr[5] = trace;
	arr[6] = 0;
	arr[7] = 0;

	arr[8] = 0;
	arr[9] = 0;
	arr[10] = trace;
	arr[11] = 0;

	arr[12] = 0;
	arr[13] = 0;
	arr[14] = 0;
	arr[15] = trace;

	return {
		mat: arr
	};
}

function m4_full(m00, m10, m20, m30,
				 m01, m11, m21, m31,
				 m02, m12, m22, m32,
				 m03, m13, m23, m33) {
	var arr = array_create(16);

	arr[0]  = m00;
	arr[1]  = m10;
	arr[2]  = m20;
	arr[3]  = m30;
		    
	arr[4]  = m01;
	arr[5]  = m11;
	arr[6]  = m21;
	arr[7]  = m31;

	arr[8]  = m02;
	arr[9]  = m12;
	arr[10] = m22;
	arr[11] = m32;
	
	arr[12] = m03;
	arr[13] = m13;
	arr[14] = m23;
	arr[15] = m33;

	return {
		mat: arr
	};
}



function m4_mul(left, right) {
	var result = m4(0);

	for (var _y = 0; _y < 4; _y++) {
		for (var _x = 0; _x < 4; _x++) {
			result.mat[_x + _y * 4] =
				left.mat[0 + _y * 4] * right.mat[_x + 0 * 4] +
				left.mat[1 + _y * 4] * right.mat[_x + 1 * 4] +
				left.mat[2 + _y * 4] * right.mat[_x + 2 * 4] +
				left.mat[3 + _y * 4] * right.mat[_x + 3 * 4];
		}
	}

	return result;
}

// lol
// https://images-ext-1.discordapp.net/external/rO9SFabhFqjN6I_Krk3qUNAeOC1MAKtlrne0QqjBqlM/%3Fauto%3Dwebp%26s%3Da9bde40b98a7791814d4c629858d1d93bc06b16c/https/external-preview.redd.it/7R0JOey7WXI8Sgv5eAc0Sl2nKnPZ6HHuoTO41fWgTHU.png?width=663&height=676

function m4_translate(v) {
	var result = m4(1);
	result.mat[3] = v.x;
	result.mat[7] = v.y;
	result.mat[11] = v.z;
	return result;
}

function m4_rotation_axis_angle(axis_ref, angle)
{
	var axis = v3_normalized(axis_ref);

	var s = msin(angle);
	var c = mcos(angle);
	var oc = 1.0 - c;

	return m4_full(oc * axis.x * axis.x + c, oc * axis.x * axis.y - axis.z * s, oc * axis.z * axis.x + axis.y * s, 0.0,
		oc * axis.x * axis.y + axis.z * s, oc * axis.y * axis.y + c, oc * axis.y * axis.z - axis.x * s, 0.0,
		oc * axis.z * axis.x - axis.y * s, oc * axis.y * axis.z + axis.x * s, oc * axis.z * axis.z + c, 0.0,
		0.0, 0.0, 0.0, 1.0);
}


function m4_rotation_euler(rotation)
{
	var z_rot = m4_rotation_axis_angle(v3(0, 0, 1), rotation.z);
	var y_rot = m4_rotation_axis_angle(v3(0, 1, 0), rotation.y);
	var x_rot = m4_rotation_axis_angle(v3(1, 0, 0), rotation.x);

	return m4_mul(y_rot, m4_mul(x_rot, z_rot));
}


// 0  1  2  3
// 4  5  6  7
// 8  9  10 11
// 12 13 14 15
function m4_scale(v) {
	var result = m4(1);
	result.mat[0] = v.x;
	result.mat[5] = v.y;
	result.mat[10] = v.z;
	return result;
}

function m4_transpose(v) {
	var result = m4(0);
	for (var _y = 0; _y < 4; _y++) {
		for (var _x = 0; _x < 4; _x++) {
			result.mat[_x + _y * 4] = v.mat[_y + _x * 4];
		}
	}
	return result;
}

function m4_project_ortho(left, right, bottom, top, near, far)
{
	return m4_full(
		2 / (right - left), 0, 0, -(right + left) / (right - left),
		0, 2 / (top - bottom), 0, -(top + bottom) / (top - bottom),
		0, 0, 1 / (far - near), -near / (far - near),
		0, 0, 0, 1
	);
}

function m4_project_perspective(fovy, aspect, near, far)
{
    var tfov2 = mtan(fovy / 2.0);
	return m4_full(
		1.0 / (aspect * tfov2), 0, 0, 0,
		0, 1.0 / (tfov2), 0, 0,
		0, 0, (far) / (far - near), -(far * near) / (far - near),
		0, 0, 1, 0
	);
}

function v4_transform(matrix, vector) {
	return v4(
			 matrix.mat[0] * vector.x + matrix.mat[1] * vector.y + matrix.mat[2] * vector.z + matrix.mat[3] * vector.w,
			 matrix.mat[0 + 4 ] * vector.x + matrix.mat[1 + 4 ] * vector.y + matrix.mat[2 + 4 ] * vector.z + matrix.mat[3 + 4 ] * vector.w,
			 matrix.mat[0 + 8 ] * vector.x + matrix.mat[1 + 8 ] * vector.y + matrix.mat[2 + 8 ] * vector.z + matrix.mat[3 + 8 ] * vector.w,
			 matrix.mat[0 + 12] * vector.x + matrix.mat[1 + 12] * vector.y + matrix.mat[2 + 12] * vector.z + matrix.mat[3 + 12] * vector.w
			 );
}


// Transform

function make_xform() {
	return {
		pos:   v3(0, 0, 0),
		rot:   m4(1),
	    scale: v3(1, 1, 1),
	};
}

function m4_xform(xform) {
	return m4_mul(m4_translate(xform.pos), m4_mul(xform.rot, m4_scale(xform.scale)));
}

function vec2(x, y) {
	if (y == undefined)
		y = x;
	return {
		x: x,
		y: y
	};
}

function vec_add(a, b) {
    return {
        x: a.x + b.x,
        y: a.y + b.y
    };
}


function vec_sub(a, b) {
    return {
        x: a.x - b.x,
        y: a.y - b.y
    };
}

function vec_mul(a, b) {
    return {
        x: a.x * b.x,
        y: a.y * b.y
    };
}

function vec_div(a, b) {
    return {
        x: a.x / b.x,
        y: a.y / b.y
    };
}


function vec_dot(a, b) {
    return a.x * b.x + a.y * b.y;
}


function vec_length(a) {
    return sqrt(a.x * a.x + a.y * a.y);
}


function vec_distance(a, b) {
    return vec_length(vec_sub(a, b));
}

function vec_manhat_distance(a, b) {
    var v = vec_sub(a, b);
    return abs(v.x) + abs(v.y);
}

function vec_normalized(a) {
	var l = vec_length(a);
	if (l == 0) l = 1;
	return vec_div(a, vec2(l));
}