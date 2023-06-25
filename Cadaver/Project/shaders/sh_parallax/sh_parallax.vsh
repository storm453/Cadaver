//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

uniform float fBbox;
uniform vec2 fObjVecOf;
uniform float fBboxHeight;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

float XstrengthOf = 0.002;
float YstrengthOf = 0.001;
float yWeightOf = 2.0;

//light options
float topLightStrength = 0.01; // 0 = no increase, 1 = white;

void main()
{
	mat4 viewMatrix = gm_Matrices[MATRIX_VIEW];
    vec2 cam_pos = -vec2(viewMatrix[3][0], viewMatrix[3][1]);
	
	//float distanceOf = distance(vec2(cam_pos.x,cam_pos.y * yWeightOf), vec2(fObjVecOf.x, fObjVecOf.y * yWeightOf)) * sign(fObjVecOf.x - cam_pos.x);
	
    //vec4 object_space_pos = vec4(in_Position.x + (fBbox - in_Position.y) * (distanceOf * strengthOf), in_Position.y, in_Position.z, 1.0);
	

    vec4 object_space_pos = vec4(in_Position.x + (in_Position.x - cam_pos.x) * XstrengthOf * (fBbox - in_Position.y), in_Position.y + (in_Position.y - cam_pos.y) * YstrengthOf * (fBbox - in_Position.y), in_Position.z, 1.0);
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;

	v_vColour.rgb *= 1.0 + (fBbox - in_Position.y)/fBboxHeight * topLightStrength;
}
