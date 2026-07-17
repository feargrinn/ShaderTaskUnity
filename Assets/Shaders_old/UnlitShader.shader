Shader "Basics/UnlitShader"
{
    Properties
    {
        _BaseColor("Base Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        Tags
        {
            "RenderPipeline" = "UniversalPipeline"
            "RenderType" = "Opaque"
            "Queue" = "Geometry"
        }
        
        Pass
        {
            HLSLPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            
            float4 _BaseColor;
            
            struct appdata // vars passed from mesh to vertex shader
            {
                float4 positionOS : POSITION; // OS = object-space (relative to origin)
            };
            
            struct v2f // from vertex to fragment shader
            {
                float4 positionCS : SV_POSITION; // clip-space position (relative to camera)
            };
            
            // vertex shader
            v2f vert(appdata v) // return_type func_name (paremeters)
            {
                v2f o = (v2f)0; // o for output, we cast 0 to the struct type to make sure
                // each member of the struct has a default value
                
                // transformation between OS and CS positions
                o.positionCS = TransformObjectToHClip(v.positionOS.xyz);
                
                return o;
            }
            
            // fragment shader
            float4 frag(v2f i) : SV_TARGET // target so graphics api knows where to bind color output
            // so screen output color
            {
                return _BaseColor;
            }
            
            ENDHLSL
        }
    }
}