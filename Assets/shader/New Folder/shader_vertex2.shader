Shader "Custom/ShaderVertex2" {
	Properties {
		_Color ("Color", Color) = (1,1,0,1)
		//环境光
		_Ambient("Ambient", Color) = (1, 1, 1, 1)
		//高光
		_Specular("Specular", Color) = (1, 1, 1, 1)
		_Shininess("Shininess", Range(0,8)) = 4.0
		//自发光
		_Emission("Emission", Color) = (0, 0, 0, 0)
		
		_FloatNumber ("FloatNumber", Float) = 0.5
		_RangeNumber ("RangeNumber", Range(0,1)) = 0.0
		//纹理贴图
		_MainTex ("Texture", 2D) = ""
		_SecondTex("SecondTexture", 2D) = ""
		
		_TestInt("TestInt",Int)=1  //Int类型
		_TestFloat("TestFloat",Float)=2.0	//Float类型
		_TestVector4("TestVector4",Vector)=(0,0,0,0)	//Vector类型
//		_TestColor("TestColor",Color) = (1,0,0,1)	//Color类型
//		_TestRange("TestRange",Range(0,100))=100	//Range类型
		_Test2D("Test2D",2D) = ""{}		//2D纹理类型
		_TestCube("TestCube",Cube) = ""{}	//Cube纹理类型，类似于天空盒，用的不多
		_Test3D("Test3D",3D) = ""{}		//3D纹理类型，用的不多
	}
	SubShader {//子Shader,一个Shader钟可以有多个SubShader
	    
	    Tags { "Queue" = "Transparent" }
	
        Pass{//渲染管道，一个SubShader可以有多个渲染管道
            //透明度渲染
            Blend SrcAlpha OneMinusSrcAlpha // 传统透明度
            
            //Color[_Color]       //Color(1,1,1,1)
            
            //定义材质的属性
            Material{
                Diffuse[_Color]   //材质的漫反射，代表材质的固有颜色
                
                //灯光计算公式
                //Ambient * Lighting Window’s Ambient Intensity setting(Unity中灯光设置的Environment Lighting中的Source属性) + (Light Color * Diffuse + Light Color * Specular) + Emission
                //Ambient  反射光,环境光
                Ambient[_Ambient]
                //Diffuse  漫反射
                //Specular 镜面反射,高光
                Specular[_Specular]
                //用Shininess的浮点值去描述高光的强度
                Shininess[_Shininess]
                //Emission 自发光
                Emission[_Emission]
            }
            //所有灯光的总开关，如果要使用灯光设置，必须要打开这个开关
            Lighting On     //Lighting Off
            //高光的开关，如果要使用镜面反射光，必须要打开这个开关
            SeparateSpecular On
            
            //设置纹理贴图
            SetTexture[_MainTex]
            {
                Combine Texture * Primary double  //固定格式 Combine:代表合并， Texture 代表当前纹理， Primary代表之前光照等数据计算的结果
                                                  //， 空格double代表数据乘以二 乘以二的原因：在0-1之间的数相乘会更加靠近0，会导致结果变得越来越暗  quad乘以四
                
            }
            //如果需要两张纹理贴图混合，则需要再次编写SetTexture， 但是能够混合的纹理贴图数量是根据硬件的好坏来改变的
            SetTexture[_SecondTex]
            {
                Combine Texture * Previous double, Texture  //这里使用了previous 这是因为Combine Texture * Primary double代表当前的纹理 * 顶点光照的颜色
                                                   //而 Previous代表当前纹理 和 先前所有计算和采样过后的结果 相乘
            }
            
        }
	}
	FallBack "Diffuse"
}
