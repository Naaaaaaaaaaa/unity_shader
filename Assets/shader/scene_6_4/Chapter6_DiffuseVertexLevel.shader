// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//实践逐顶点光照
Shader "Custom/Chapter6/DiffuseVertexLevel"
{
    Properties{
        _Diffuse ("Diffuse", Color) = (1.0, 1.0, 1.0, 1.0)
    }

    SubShader{
        Pass{
            Tags{"LightMode" = "ForwardBase"}
            
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            
            #include "Lighting.cginc"
            
            fixed4 _Diffuse;
            
            struct a2v{
                float4 vertex : POSITION;
                float3 normal: NORMAL;
            };
            
            struct v2f{
                float4 pos : SV_POSITION;
                fixed3 color : COLOR;
            };
            
            v2f vert(a2v v){
                v2f o;
                
                //将顶点、方向矢量从模型空间变换到裁剪空间
                o.pos = UnityObjectToClipPos(v.vertex);
                //得到环境光的强度和颜色
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                //将法线从物体空间转换为世界空间
                fixed3 worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
                //获取光在世界空间的方向
                fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                //计算漫反射
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLight)); 
                
                o.color = ambient + diffuse;
                
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target{
                return fixed4(i.color, 1.0);
            }
            
            ENDCG
        }
    }
    FallBack "Diffuse"
}
