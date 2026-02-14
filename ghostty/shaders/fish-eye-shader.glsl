void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Normalize pixel coordinates
    vec2 uv = fragCoord.xy / iResolution.xy;

    // Curvature (reduced distortion)
    vec2 centered_uv = uv * 2.0 - 1.0;
    centered_uv *= vec2(1.0 + (centered_uv.y * centered_uv.y) * 0.01,
                        1.0 + (centered_uv.x * centered_uv.x) * 0.015);
    uv = centered_uv * 0.5 + 0.5;

    // Boundary check (black out edges outside 0-1)
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }

    // Sample the terminal texture from channel 0
    vec4 color = texture(iChannel0, uv);

    fragColor = color;
}