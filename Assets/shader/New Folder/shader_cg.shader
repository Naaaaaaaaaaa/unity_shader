Shader "Custom/shader_cg"
{

    SubShader
    {
        pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            void vert(in float2 objFos:POSITION, out float4 pos:POSITION, out float4 col:COLOR)
            {
                pos = float4(objFos,0,1);
                col = pos;
            }
            void frag(inout float4 col:COLOR)
            {
//                col = float4(1, 1, 0, 1);
            }
            
            ENDCG
        }
    }
    
//    FallBack "Diffuse"
}
