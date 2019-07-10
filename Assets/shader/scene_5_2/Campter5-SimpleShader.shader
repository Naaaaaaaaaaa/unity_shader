// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Chapter5/SimpleShader"
{
    Properties{
        _Color ("Color Tint", Color) = (1.0, 1.0, 1.0, 1.0)
    }

    SubShader{
        Pass{
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            
            fixed4 _Color;
            
            struct a2v{
                //POSITION告诉UNITY,用模型空间的顶点坐标填充vertex变量
                float4 vertex : POSITION;
                //NORMAL语句告诉Unity， 用模型空间的发现方向来填充normal变量
                float3 normal : NORMAL;
                //TEXCOORD0语义告诉Unity， 用模型的第一套纹理坐标填充texcoord变量
                float4 texcoord : TEXCOORD0;
            };
            
            //使用一个结构体来定义顶点着色器的输出
            struct v2f{
                //SV_POSITION语义告诉unity，pos里面包含了顶点在裁剪空间中的位置信息
                float4 pos : SV_POSITION;
                //COLOR0语义可以用于存储颜色信息
                fixed3 color : COLOR0;
            };
            
            v2f vert(a2v v){
                //使用v.vertex来访问模型空间的顶点坐标
                //return UnityObjectToClipPos(v.vertex);
                
                //声明输出结构
                v2f o;
            	o.pos = UnityObjectToClipPos(v.vertex);
            	//v.normal包含了顶点的法线方向，其分量范围在[-1.0, 1.0]
            	//下面的代码吧分量范围映射到[0.0, 1.0]
            	//存储到o.color中传递给片元着色器
            	o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target{
                fixed3 c = i.color;
                c *= _Color.rgb;  
                return fixed4(c, 1.0);
            }
            
            ENDCG
        }
    }
}
