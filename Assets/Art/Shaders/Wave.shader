// Shader created with Shader Forge v1.17 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.17;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|emission-3834-OUT;n:type:ShaderForge.SFN_Fresnel,id:6518,x:32427,y:33158,varname:node_6518,prsc:2;n:type:ShaderForge.SFN_Power,id:137,x:32643,y:33158,varname:node_137,prsc:2|VAL-6861-OUT,EXP-9505-OUT;n:type:ShaderForge.SFN_Vector1,id:9505,x:32419,y:33308,varname:node_9505,prsc:2,v1:5;n:type:ShaderForge.SFN_Vector3,id:6975,x:32685,y:32787,varname:node_6975,prsc:2,v1:0,v2:1,v3:0.5862069;n:type:ShaderForge.SFN_Multiply,id:3834,x:32896,y:32858,varname:node_3834,prsc:2|A-3512-RGB,B-137-OUT;n:type:ShaderForge.SFN_Dot,id:2655,x:32075,y:32918,varname:node_2655,prsc:2,dt:0|A-8764-OUT,B-1772-OUT;n:type:ShaderForge.SFN_Vector3,id:8764,x:31818,y:32902,varname:node_8764,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_NormalVector,id:1772,x:31818,y:33019,prsc:2,pt:False;n:type:ShaderForge.SFN_OneMinus,id:6861,x:32468,y:32918,varname:node_6861,prsc:2|IN-4057-OUT;n:type:ShaderForge.SFN_Abs,id:4057,x:32269,y:32916,varname:node_4057,prsc:2|IN-2655-OUT;n:type:ShaderForge.SFN_Color,id:3512,x:32685,y:32632,ptovrint:False,ptlb:Glow,ptin:_Glow,varname:node_3512,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:1,c3:0.5843138,c4:1;proporder:3512;pass:END;sub:END;*/

Shader "Shader Forge/Wave" {
    Properties {
        _Glow ("Glow", Color) = (0,1,0.5843138,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _Glow;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float3 normalDir : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float3 emissive = (_Glow.rgb*pow((1.0 - abs(dot(float3(0,1,0),i.normalDir))),5.0));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
