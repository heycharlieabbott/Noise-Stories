#define maxdist 100.
#define maxsteps 90
#define surfdist .1


float SphereDist(float3 p, float3 ptwo, float rad, float3 modvec, float3 cubesize){

      p.x = fmod(p.x, modvec.x) - modvec.x/2.;
      p.y = fmod(p.y, modvec.y) - modvec.y/2.;
      p.z = fmod(p.z, modvec.z) - modvec.z/2.;


 //p *= sin(p*(sin(ptwo.x/20.)));
  //p *= sin(p*(sin(ptwo.y/20.)));
  
  p *= abs(sin(p*(sin(ptwo.y/20.)-2.)));

  ptwo = float3(0.,0.,0.);

  float sphere = length(p)/ rad;

  float3 size = cubesize;
  
  float cube = length(max(abs(p)-size,0.));

  float d = max(cube,sphere* sin(p));


  //d -= sin(p.x/4.)/1.2;

  //d-= dot(p,d);
   
  return d;
  }

  float3 GetNormal(float3 p, float3 ptwo, float rad, float3 modvec, float3 cubesize){
    float2 e = float2(0.02, 0.);
    float3 n = SphereDist(p, ptwo, rad, modvec, cubesize) - float3(
        SphereDist((p - e.xyy),ptwo, rad, modvec, cubesize),
        SphereDist((p - e.yxy), ptwo, rad, modvec, cubesize),
        SphereDist((p - e.yyx),ptwo, rad, modvec, cubesize));
    return normalize(n);
  }
 
 
 float RayMarch (float3 ro, float3 rd, float3 modvec, float rad, float3 cubesize){
 float dO = 0.;
//  float maxdist = 100.;
//  int maxsteps = 50;
//  float surfdist = .01;
 
   for (int i=0; i<maxsteps; i++){
     float3 p = ro + rd * dO;
     float dS = SphereDist(p, ro, rad, modvec, cubesize);
     dO += dS;
     if(dO>maxdist || dS <surfdist) break;
   }
   return dO;
 }



void marcher_float (float3 campos, float3 rd, float2 uv, float3 modvec, float rad, float time, float3 cubesize, float noise, float fogcontrol, float fogwarp, out float4 col, out float al){
    col = float4(0.,0.,0.,1.);
    al = 1.;

    //campos = float3(0.,0.,-9.);

    rd.y *= -1.;

    float3 camnorm = (rd);

    uv.xy -= 0.5;

    rd = normalize(float3(uv.x - camnorm.x,uv.y - camnorm.y,1));

    float radoff = sin(time/2.) *4.; 

    float d = RayMarch(campos,rd, modvec + noise, rad + radoff, cubesize);

    float fog = 1-d/maxdist*fogcontrol;

    float3 n = GetNormal(campos/200.,rd, modvec, rad + 10., cubesize);

    if (d < maxdist){

        col.rgb = 1.;
       //float3 n = GetNormal(campos/10.,rd, modvec + noise, rad + 10., cubesize);
        rd.x *= sin(time) * 7.;
        col.rgb = dot(n,rd + sin(time));
        if (fogwarp >= 1.){
          col *= sin(fog * fogwarp);
          col.r *= abs(cos(campos.z /30.));
          col.g *= abs(sin(campos.y / 20.))/2.;
          col.b *= abs(sin(col.r * col.g * 3.));
          col *= fog;
        }
        //else col.rgb *= pow(fog,3. - n);
        else col.rgb *= fog;
        
    }

    else {
        al = 0.;
        // col.rgb += 0.2;
        // col.r *= fmod(sin(d*3.),0.8);
        // col.g *= fmod(cos(d*20.),0.3);
        // col.b *= fmod(tan(d),0.3);

    }
    
}