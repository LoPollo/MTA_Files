texture screenSource;
float bitDepth = 8;
float2 tiles = float2(16, 10);


sampler TextureSampler = sampler_state {
    Texture = <screenSource>;
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Mirror;
    AddressV = Mirror;
};


float4 PixelShaderFunction(float2 texCoords : TEXCOORD0) : COLOR0 {	

	float2 brickSize = 1.0 / tiles;
	float2 offsetuv = texCoords;
	
	bool oddRow = floor(offsetuv.y / brickSize.y) % 2.0 >= 1.0;

	if (oddRow) {
		offsetuv.x += brickSize.x / 2.0;
	}
	
	float2 brickNum = floor(offsetuv / brickSize);
	float2 centerOfBrick = brickNum * brickSize + brickSize / 2;
	float4 color = tex2D(TextureSampler, centerOfBrick);
	
	color.rgb /= color.a;
	color.rgb *= bitDepth;
	color.rgb = floor(color.rgb);
	color.rgb /= bitDepth;
	color.rgb *= color.a;
  
	return color;
}
 

technique eightBit {
    pass P0 {
        AlphaRef = 1;
        AlphaBlendEnable = true;
        PixelShader  = compile ps_2_0 PixelShaderFunction();
    }
}

// Fallback
technique Fallback {
    pass P0 {
        // Just draw normally
    }
}