Shader "Basics/BasicTexturing"
{
    Properties
    {
        _BaseColor("Base Color", Color) = (1, 1, 1, 1)
        _BaseTexture("Base Texture", 2D) = "white" {}
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
            float4 _BaseTexture_ST; // tiling and offset
            
            TEXTURE2D(_BaseTexture);
            SAMPLER(sampler_BaseTexture); // clamp uv coords and filtering
            
            
            struct appdata // vars passed from mesh to vertex shader
            {
                float4 positionOS : POSITION; // OS = object-space (relative to origin)
                
                // read texture coords from the mesh
                float2 uv : TEXCOORD0;
            };
            
            struct v2f // from vertex to fragment shader
            {
                float4 positionCS : SV_POSITION; // clip-space position (relative to camera)
                float2 uv : TEXCOORD0;
            };
            
            // vertex shader
            v2f vert(appdata v) // return_type func_name (paremeters)
            {
                v2f o = (v2f)0; // o for output, we cast 0 to the struct type to make sure
                // each member of the struct has a default value
                
                // transformation between OS and CS positions
                o.positionCS = TransformObjectToHClip(v.positionOS.xyz);
                
                o.uv = TRANSFORM_TEX(v.uv, _BaseTexture); // applies the _textname_ST var values
                
                return o;
            }
            
            // fragment shader
            float4 frag(v2f i) : SV_TARGET // target so graphics api knows where to bind color output
            // so screen output color
            {
                // sampling the texture
                float4 textureColor = SAMPLE_TEXTURE2D(_BaseTexture, sampler_BaseTexture, i.uv);
                return textureColor * _BaseColor;
            }
            
            ENDHLSL
        }
    }
}