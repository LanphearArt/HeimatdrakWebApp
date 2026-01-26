shader_type spatial;
render_mode cull_disabled, depth_draw_opaque;

uniform vec3 base_color : source_color = vec3(0.9, 0.9, 0.9);
uniform float dissolve_amount : hint_range(0.0, 1.1) = 0.0;
uniform sampler2D noise_texture : hint_default_black;
uniform vec3 glow_color : source_color = vec3(1.0, 0.4, 0.0); // orange melt
uniform float glow_intensity : hint_range(0.0, 10.0) = 5.0;
uniform float glow_border_width : hint_range(0.0, 0.3) = 0.08;

void fragment() {
    float noise = texture(noise_texture, UV).r;
    
    // Dissolve clip
    if (noise < dissolve_amount) {
        discard;
    }
    
    ALBEDO = base_color;
    
    // Glow edge
    float edge = dissolve_amount + glow_border_width;
    if (noise < edge) {
        float glow = smoothstep(dissolve_amount, edge, noise);
        EMISSION += glow_color * glow * glow_intensity;
    }
}