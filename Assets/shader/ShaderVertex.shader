Shader "Custom/ShaderVertex" {
	Properties {
		_Color ("Color", Color) = (1,1,0,1)
		_FloatNumber ("FloatNumber", Float) = 0.5
		_RangeNumber ("RangeNumber", Range(0,1)) = 0.0
		
		
		_MainTex ("Texture", 2D) = "white" {}
		_TestInt("TestInt",Int)=1  //Int类型
		_TestFloat("TestFloat",Float)=2.0	//Float类型
		_TestVector4("TestVector4",Vector)=(0,0,0,0)	//Vector类型
		_TestColor("TestColor",Color) = (1,0,0,1)	//Color类型
		_TestRange("TestRange",Range(0,100))=100	//Range类型
		_Test2D("Test2D",2D) = ""{}		//2D纹理类型
		_TestCube("TestCube",Cube) = ""{}	//Cube纹理类型，类似于天空盒，用的不多
		_Test3D("Test3D",3D) = ""{}		//3D纹理类型，用的不多
	}
	SubShader {//子Shader,一个Shader钟可以有多个SubShader
        Pass{//渲染管道，一个SubShader可以有多个渲染管道
            Color[_Color]
            
            //定义材质的属性
            Material{
                //Diffuse(1, 1, 1, 1)
                
                //灯光计算公式
                //Ambient * Lighting Window’s Ambient Intensity setting(Unity中灯光设置的Environment Lighting中的Source属性) + (Light Color * Diffuse + Light Color * Specular) + Emission
                //Ambient  反射光
                //Diffuse  漫反射
                //Specular 镜面反射
                //Emission 自发光
            }
            //所有灯光的总开关，如果要使用灯光设置，必须要打开这个开关
            //Lighting On
            //高光的开关，如果要使用镜面反射光，必须要打开这个开关
            //SeparateSpecular On
            
        }
	}
	FallBack "Diffuse"
}
