//-----------------------------------------------------------------------------
// Copyright (c) 2012 GarageGames, LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//-----------------------------------------------------------------------------

//*****************************************************************************
// Precipitation vertex shader
//*****************************************************************************
//-----------------------------------------------------------------------------
// Constants
//-----------------------------------------------------------------------------
struct Vert
{
	float4 position	: POSITION;
	float4 texCoord	: TEXCOORD0;
};

struct Conn
{
	float4 position : POSITION;
	float4 texCoord	: TEXCOORD0;
	float4 color : COLOR0;
};

//-----------------------------------------------------------------------------
// Main
//-----------------------------------------------------------------------------
Conn main(  Vert In, 
            uniform float4x4 modelview : register(C0),
	    uniform float2 fadeStartEnd : register(C4),
	    uniform float3 cameraPos : register(C5),
	    uniform float3 ambient : register(C6)
)
{
   Conn Out;

   Out.position = mul(modelview, In.position);
   Out.texCoord = In.texCoord;
   Out.color = float4( ambient.r, ambient.g, ambient.b, 1 );

   // Do we need to do a distance fade?
   if ( fadeStartEnd.x < fadeStartEnd.y ) {

      float distance = length( cameraPos - In.position );
      Out.color.a = abs( clamp( ( distance - fadeStartEnd.x ) / ( fadeStartEnd.y - fadeStartEnd.x ), 0, 1 ) - 1 );
   }

   return Out;
}

