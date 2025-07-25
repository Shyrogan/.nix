#define Alias 0.00001
#define Pixels 100.0
#define Bias 0.001
#define PI 3.14

#define TIME iTime*1.0
// https://catppuccin.com/palette/
#define COL_BG vec3(30.0/255.0, 30.0/255.0, 46.0/255.0)
#define COL_SHADOW vec3(49.0/255.0, 50.0/255.0, 68.0/255.0)
#define COL_SHADOW2 vec3(69.0/255.0, 71.0/255.0, 90.0/255.0)
#define COL_SHADOW3 vec3(88.0/255.0, 91.0/255.0, 112.0/255.0)
#define COL_LIGHT1 vec3(166.0/255.0, 173.0/255.0, 200.0/255.0)
#define COL_LIGHT2 vec3(205.0/255.0, 214.0/255.0, 244.0/255.0)
#define COL_C1 vec3(235.0/255.0, 160.0/255.0, 172.0/255.0)
#define COL_C2 vec3(250.0/255.0, 179.0/255.0, 135.0/255.0)

// VV From https://blog.maximeheckel.com/posts/the-art-of-dithering-and-retro-shading-web/
const float bayerMatrix8x8[64] = float[64](
        0.0 / 64.0, 48.0 / 64.0, 12.0 / 64.0, 60.0 / 64.0, 3.0 / 64.0, 51.0 / 64.0, 15.0 / 64.0, 63.0 / 64.0,
        32.0 / 64.0, 16.0 / 64.0, 44.0 / 64.0, 28.0 / 64.0, 35.0 / 64.0, 19.0 / 64.0, 47.0 / 64.0, 31.0 / 64.0,
        8.0 / 64.0, 56.0 / 64.0, 4.0 / 64.0, 52.0 / 64.0, 11.0 / 64.0, 59.0 / 64.0, 7.0 / 64.0, 55.0 / 64.0,
        40.0 / 64.0, 24.0 / 64.0, 36.0 / 64.0, 20.0 / 64.0, 43.0 / 64.0, 27.0 / 64.0, 39.0 / 64.0, 23.0 / 64.0,
        2.0 / 64.0, 50.0 / 64.0, 14.0 / 64.0, 62.0 / 64.0, 1.0 / 64.0, 49.0 / 64.0, 13.0 / 64.0, 61.0 / 64.0,
        34.0 / 64.0, 18.0 / 64.0, 46.0 / 64.0, 30.0 / 64.0, 33.0 / 64.0, 17.0 / 64.0, 45.0 / 64.0, 29.0 / 64.0,
        10.0 / 64.0, 58.0 / 64.0, 6.0 / 64.0, 54.0 / 64.0, 9.0 / 64.0, 57.0 / 64.0, 5.0 / 64.0, 53.0 / 64.0,
        42.0 / 64.0, 26.0 / 64.0, 38.0 / 64.0, 22.0 / 64.0, 41.0 / 64.0, 25.0 / 64.0, 37.0 / 64.0, 21.0 / 64.0
    );

float orderedDither(vec2 uv, float lum) {
    vec3 color = vec3(0.0);
    int x = int(mod(uv.x,8.0));
    int y = int(mod(uv.y,8.0));
    float threshold = bayerMatrix8x8[y * 8 + x];

    if (lum < threshold + Bias) {
        return 0.0;
    } else {
        return 1.0;
    }
}
// ^^ From https://blog.maximeheckel.com/posts/the-art-of-dithering-and-retro-shading-web/

float circle(vec2 uv, float len) {
    return length(uv) - len;
}

mat2 rotate(float theta) {
    float c = cos(theta);
    float s = sin(theta);
    return mat2(
        vec2(c, -s),
        vec2(s, c)
    );
}

mat3 rotateY(float theta) {
    float c = cos(theta);
    float s = sin(theta);
    return mat3(
        vec3(c, 0, s),
        vec3(0, 1, 0),
        vec3(-s, 0, c)
    );
}

// VV From https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83#perlin-noise
float rand(vec2 c) {
    return fract(sin(dot(c.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

float noise(vec2 p, float freq) {
    float unit = (Pixels * 30.0) / freq;
    vec2 ij = floor(p / unit);
    vec2 xy = mod(p, unit) / unit;
    xy = 0.5 * (1.0 - cos(PI * xy));
    float a = rand((ij + vec2(0.0, 0.0)));
    float b = rand((ij + vec2(1.0, 0.0)));
    float c = rand((ij + vec2(0.0, 1.0)));
    float d = rand((ij + vec2(1.0, 1.0)));
    float x1 = mix(a, b, xy.x);
    float x2 = mix(c, d, xy.x);
    return mix(x1, x2, xy.y);
}

float pNoise(vec2 p, int res) {
    float persistance = 0.5;
    float n = 0.0;
    float normK = 0.0;
    float f = 4.0;
    float amp = 1.0;
    int iCount = 0;
    for (int i = 0; i < 50; i++) {
        n += amp * noise(p, f);
        f *= 2.0;
        normK += amp;
        amp *= persistance;
        if (iCount == res) break;
        iCount++;
    }
    float nf = n / normK;
    return nf * nf * nf * nf;
}
// ^^ From https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83#perlin-noise

float saturate(float f) {
    return min(1.0, max(0.0, f));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    uv -= vec2(0.5);
    uv.x *= iResolution.x / iResolution.y;
    uv = floor(uv / 0.5 * Pixels);
    vec2 screenUV = uv;
    uv /= Pixels;

    if (abs(uv.y) > 0.78) {
        fragColor.rgb = COL_BG;
        return;
    }

    uv = rotate(-0.4) * uv;
    uv /= 1.3 - (sin(TIME * 0.05) + 1.0) * 0.3;
    uv.y += 0.3;

    vec4 uvColor = vec4(uv.x, uv.y, 0, 1);
    vec3 normal = normalize(vec3(uv, sqrt(max(Alias,1.0 - uv.x * uv.x - uv.y * uv.y))));
    vec3 localNormal = normal;

    vec3
    sun = normalize(vec3(1.0, 0.8, 0.0));
    sun = rotateY(-TIME + 0.5) * sun;

    float
    light = dot(sun, normal);
    light = pow(light, 1.0);

    float c = circle(uv, 1.0);

    vec3 ring = vec3(uv.xy, 1.0);
    vec2 ringUV = uv.xy;
    float ringCulling = dot(ringUV, vec2(0.0, -1.0));
    ringUV.y /= 0.2;
    vec3 ringPos = vec3(-ringUV.x, 0, ringUV.y);
    float k = dot(-ringPos, sun);

    float ringLight = length(ringPos + sun * k);
    if (k > 0.0) ringLight = 1.0;
    ringUV = ringPos.xz;

    float rotTime = TIME * 0.1;
    ringUV = (rotateY(rotTime) * ringPos).xz;
    float ringy = length(ringUV);

    float
    ringf = 1.0 - abs(1.5 - ringy);
    ringf = smoothstep(0.5, 1.0, ringf);

    float angle = atan(ringUV.y, ringUV.x) / (2.0 * 3.14);
    float ringNoise = pNoise(vec2(ringf * 30.0, abs(angle) * 30.0) / 0.09 * 24.0, 4) * ringf;

    ring = vec3(abs(sin(ringy * 30.0)) * ringf * ringNoise);
    ring = vec3(ringNoise);

    vec3
    ringColor = vec3(0.0);
    ringColor = mix(ringColor, COL_SHADOW3, orderedDither(screenUV, smoothstep(0.0, 0.1, ringNoise)));
    ringColor = mix(ringColor, COL_C1, orderedDither(screenUV, smoothstep(0.1, 0.2, ringNoise)));
    ringColor = mix(ringColor, COL_C2, orderedDither(screenUV, smoothstep(0.02, 0.3, ringNoise)));
    ringColor = mix(ringColor, COL_LIGHT1, orderedDither(screenUV, smoothstep(0.07, 0.3, ringNoise)));
    ringColor *= orderedDither(screenUV, smoothstep(0.9, 1.0, ringLight));

    normal = normalize(rotateY(rotTime * 2.0) * normal);

    vec2
    planetUV = vec2(atan(normal.x, -normal.z), atan(length(normal.xz), normal.y)) * 4.0;
    planetUV = abs(planetUV) * 1.0;

    float f1 = pNoise(vec2(planetUV.x / 10.0 + 7.0, planetUV.y * 0.9 + 7.4) / 0.001, 4);
    planetUV += f1 * 7.0;

    float
    factor = (pNoise(vec2(planetUV.x / 20.0, planetUV.y * 0.4 + 7.3) / 0.001, 4) - 0.1) / 0.3;
    factor = saturate((factor + 1.0) / 2.0);
    factor = min(1.0, abs(factor));

    vec3
    color = mix(COL_SHADOW, COL_SHADOW2, orderedDither(screenUV, factor));
    color = mix(color, COL_SHADOW3, orderedDither(screenUV, smoothstep(0.4, 0.6, factor)));
    color = mix(color, COL_LIGHT1, orderedDither(screenUV, smoothstep(0.5, 0.8, factor)));
    color = mix(color, COL_LIGHT2, orderedDither(screenUV, smoothstep(0.8, 1.0, factor)));
    color = mix(color, COL_C1, orderedDither(screenUV, smoothstep(0.05, 0.15, 0.5 - factor)));
    color = mix(color, COL_C2, orderedDither(screenUV, smoothstep(0.1, 0.15, 0.5 - factor)));

    float
    rim = orderedDither(screenUV, pow(1.0 - dot(localNormal, vec3(0.0, 0.0, 1.0)), 3.0));
    rim *= pow(saturate(light + 0.4), 1.0);

    float light_att = saturate(orderedDither(screenUV, light) + rim + smoothstep(0.1, 0.9, light));
    vec3 planet_color = mix(COL_BG, color, light_att);
    float planetAlpha = smoothstep(Alias, -Alias, c);
    float ringAlpha = saturate(length(ringColor) / 0.01) * saturate(1.0 - planetAlpha + smoothstep(0.0, Alias, ringCulling));

    vec3 final_color = mix(COL_BG, planet_color, planetAlpha);
    final_color = mix(final_color, ringColor, ringAlpha);
    fragColor = vec4(final_color, 1.0);
}

