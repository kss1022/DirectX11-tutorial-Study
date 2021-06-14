//--------------------------------------------------------------------------------------
// File: Tutorial04.fx
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// Constant Buffer Variables
//--------------------------------------------------------------------------------------
cbuffer ConstantBuffer : register( b0 )	//0번 레지스터에 들어온다.
{
	matrix World;			//matric 4 * 4 -> 64byte
	matrix View;
	matrix Projection;
}

//--------------------------------------------------------------------------------------
struct VS_OUTPUT
{
    float4 Pos : SV_POSITION;
    float4 Color : COLOR0;
};

//--------------------------------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------------------------------
VS_OUTPUT VS( float4 Pos : POSITION, float4 Color : COLOR )
{
    VS_OUTPUT output = (VS_OUTPUT)0;
    output.Pos = mul( Pos, World );	
	//전치되어 들어온다고 가정하고 작동함
	//ouput.Pos.x = dot(Pos.xyzw, World_m00_m01_02_m03);
	//ouput.Pos.y = dot(Pos.xyzw, World_m10_m11_12_m13);
	//ouput.Pos.z = dot(Pos.xyzw, World_m00_m21_22_m23);
	//ouput.Pos.w = dot(Pos.xyzw, World_m00_m31_32_m33);


    output.Pos = mul( output.Pos, View );
    output.Pos = mul( output.Pos, Projection );
    output.Color = Color;
    return output;
}


//--------------------------------------------------------------------------------------
// Pixel Shader		픽셀마다 호출이됨		
			//삼각형 단위로 그려짐  하드웨어적으로 변과 변 사이는 보간이 일어남  그러므로 픽셀셰이더 호출이 됨
//--------------------------------------------------------------------------------------
float4 PS( VS_OUTPUT input ) : SV_Target
{
    return input.Color;
}
