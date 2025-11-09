varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 colorInversion = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	colorInversion.rgb = 1.0 - colorInversion.rgb;
	gl_FragColor = colorInversion;
}