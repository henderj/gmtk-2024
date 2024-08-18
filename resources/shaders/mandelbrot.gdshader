shader_type canvas_item;

uniform int iteration_limit = 500;
uniform vec2 view = vec2(-0.75, 0.0);
uniform float zoom: hint_range(0.0, 15.0) = 0.0;
uniform float ratio = 1.0;
uniform sampler2D palette_image: source_color;

// Returns: vec4(final position, iterations, is inside the set)
vec4 mandelbrot(vec2 c, int iterations) {
	vec2 z = vec2(0.0, 0.0);
	vec2 z2 = vec2(0.0, 0.0);
	int i = 0;
	
	while (z2.x + z2.y <= 4.0 && ++i < iterations) {
		z = vec2(z2.x - z2.y + c.x, 2.0 * z.x * z.y + c.y);
		z2 = z * z;
	}
	
	return vec4(z, float(i), i == iterations ? 1.0 : 0.0);
}

vec4 mandelbrot_smooth(vec2 c, int iterations) {
	vec4 m = mandelbrot(c, iterations);

	return vec4(
		m.xy,
		m.z + 1.0 - log(log(m.x * m.x + m.y * m.y) / 2.0 / log(2)) / log(2),
		m.w
	);
}

vec3 palette(vec4 m) {
	int color_count = textureSize(palette_image, 0).x - 1;
	
	if (m.w == 1.0) {
		return texelFetch(palette_image, ivec2(0, 0), 0).rgb;
	}
	
	vec3 color1 = texelFetch(palette_image, ivec2(1 + int(m.z) % color_count, 0), 0).rgb;
	vec3 color2 = texelFetch(palette_image, ivec2(1 + (int(m.z) + 1) % color_count, 0), 0).rgb;
	return mix(color1, color2, fract(m.z));
}

void fragment() {
	vec2 uv = ((UV - vec2(0.5)) * vec2(ratio, 1.0)) / exp(zoom - 1.25) + view;
	
	vec4 result = mandelbrot_smooth(uv, iteration_limit);
	vec3 color = palette(result);
	
	COLOR = vec4(color, 1.0);
}