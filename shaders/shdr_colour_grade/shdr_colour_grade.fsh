//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_lut;
uniform vec4 u_lutUvs;


uniform float u_time;


// This is super bodge
const float lutRes = 512.;



vec4 lutRaw(vec2 uv) {
    return texture2D( u_lut, mix(u_lutUvs.xy, u_lutUvs.zw, uv) );
}

vec4 lutFiltered(vec2 uv)
{
    vec2 px = vec2(1)/lutRes;

    vec4 bl = lutRaw(uv + vec2(0, 0) * px);
    vec4 br = lutRaw(uv + vec2(1, 0) * px);
    vec4 tl = lutRaw(uv + vec2(0, 1) * px);
    vec4 tr = lutRaw(uv + vec2(1, 1) * px);

    vec2 f = fract(uv / px);

	vec2 ibl = floor((uv + vec2(0, 0) * px) * 8.0);
	vec2 itr = floor((uv + vec2(1, 1) * px) * 8.0);

    if (ibl.x != itr.x) f.x = 0.;
    if (ibl.y != itr.y) f.y = 0.;

    return mix(
        mix(bl, br, f.x),
        mix(tl, tr, f.x),
        f.y
    );
}

vec4 lutIndex(vec3 i) {
	float i0z=floor(i.z * 64.0);
	float i1z=ceil(i.z * 64.0);
	float imz=fract(i.z * 64.0);
   
	vec2 uv0 = clamp(i.xy / 8., 0., 63./64./8.) + vec2(i0z / 8.0, floor(i0z / 8.0) / 8.0);
    uv0.x=fract(uv0.x);
    uv0.y=clamp(uv0.y, 0., 1.);
   
	vec2 uv1 = clamp(i.xy / 8., 0., 63./64./8.) + vec2(i1z / 8.0, floor(i1z / 8.0) / 8.0);
    uv1.x=fract(uv1.x);
    uv1.y=clamp(uv1.y, 0., 1.);
   
	return mix(
		lutFiltered(uv0),
		lutFiltered(uv1),
		imz);
}

void main()
{
	//gm_BaseTexture
    vec4 cab = texture2D(gm_BaseTexture, v_vTexcoord);

    // vec3 i = cab.xyz;
    // vec2 offset = vec2(mod(min(i.b * 64.0, 62.0), 8.0), floor(min(i.b * 64.0, 62.0)/ 8.0));
    // vec2 offset2 = vec2(mod(min(i.b * 64.0, 63.0) + 1.0, 8.0), floor((min(i.b * 64.0, 63.0) + 1.0)/ 8.0));
    // vec2 first = clamp(fract(i.rg / 8.0) + floor(offset) / 8.0, 0., 1.);
    // vec2 second = clamp(fract(i.rg / 8.0) + floor(offset2) / 8.0, 0., 1.);
    // vec4 t1 = texture2D( u_lut, mix(u_lutUvs.xy, u_lutUvs.zw, first) );
    // vec4 t2 = ;
    


    gl_FragColor = lutIndex(cab.rgb);
}
