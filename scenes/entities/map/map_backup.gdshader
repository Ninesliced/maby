shader_type canvas_item;

uniform sampler2D ground_cols;
uniform int number_of_ground_cols = 8;
uniform sampler2D screen_texture: hint_screen_texture, repeat_disable;

uniform vec3 color_fill : source_color;
uniform float force: hint_range(0,1.0);

void vertex() {
}

bool match_color(vec3 color, vec3 target_color) {
	return distance(color, target_color) < 0.01;
}

int get_ground_index(vec4 color) {
	int ground_index = -1;
	for (int i = 0;  i < number_of_ground_cols; i++) {
		vec3 ground_col_i = texelFetch(ground_cols, ivec2(0, i), 0).rgb;
		int match = int(match_color(color.rgb, ground_col_i)) * i;
		ground_index = match == 1 ? i : ground_index;
	}
	return ground_index;
}

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);

	int ground_index = get_ground_index(COLOR);

	vec3 ground_col = texelFetch(ground_cols, ivec2(1, ground_index), 0).rgb;
	vec3 wall_col = texelFetch(ground_cols, ivec2(0, ground_index), 0).rgb;
	vec3 shadow_col = texelFetch(ground_cols,ivec2(2, ground_index), 0).rgb;

	bool is_ground = match_color(COLOR.rgb, ground_col);

	vec4 above_pixel = texture(screen_texture,vec2(SCREEN_UV.x, SCREEN_UV.y - SCREEN_PIXEL_SIZE.y * 20.0));

	bool is_above_wall = match_color(above_pixel.rgb, wall_col);

	if (is_ground && (is_above_wall)) {
		COLOR.rgb = mix(COLOR.rgb, shadow_col, 1.0);
	}

	//wall
	int above_index = get_ground_index(above_pixel);
	ground_col = texelFetch(ground_cols, ivec2(1, above_index), 0).rgb;
	wall_col = texelFetch(ground_cols, ivec2(0, above_index), 0).rgb;
	shadow_col = texelFetch(ground_cols,ivec2(2, above_index), 0).rgb;

	if (above_pixel.a == 1.0 && COLOR.a == 0.0) {
		COLOR.rgba = vec4(shadow_col, 1.0);
	}

	vec4 s_color = texture(screen_texture, SCREEN_UV);
	COLOR.rgb = mix(COLOR.rgb, color_fill, force);
}
