// Standard geometry shader example
// https://github.com/keijiro/StandardGeometryShader

Shader "Standard Geometry Shader Example"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        _MainTex("Albedo", 2D) = "white" {}

        [Space]
        _Glossiness("Smoothness", Range(0, 1)) = 0.5
        [Gamma] _Metallic("Metallic", Range(0, 1)) = 0

        [Space]
        _BumpMap("Normal Map", 2D) = "bump" {}
        _BumpScale("Scale", Float) = 1

        [Space]
        _OcclusionMap("Occlusion Map", 2D) = "white" {}
        _OcclusionStrength("Strength", Range(0, 1)) = 1

        [Space]
        _LocalTime("Animation Time", Float) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        // This shader only implements the deferred rendering pass (GBuffer
        // construction) and the shadow caster pass, so that it doesn't
        // support forward rendering.

        Pass
        {
            Tags { "LightMode"="Deferred" }
            CGPROGRAM
            #pragma target 4.0
            #pragma vertex Vertex
            #pragma geometry Geometry
            #pragma fragment Fragment
            #pragma multi_compile_prepassfinal noshadowmask nodynlightmap nodirlightmap nolightmap
            #include "StandardGeometry.cginc"
            ENDCG
        }

        Pass
        {
            Tags { "LightMode"="ShadowCaster" }
            CGPROGRAM
            #pragma target 4.0
            #pragma vertex Vertex
            #pragma geometry Geometry
            #pragma fragment Fragment
            #pragma multi_compile_shadowcaster noshadowmask nodynlightmap nodirlightmap nolightmap
            #define UNITY_PASS_SHADOWCASTER
            #include "StandardGeometry.cginc"
            ENDCG
        }
    }
}
