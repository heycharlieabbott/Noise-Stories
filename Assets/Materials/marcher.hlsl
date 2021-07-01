#define maxdist 100.
#define maxsteps 90
#define surfdist .1


float SphereDist(float3 p, float3 ptwo, float rad, float3 modvec){

      p.x = fmod(p.x, modvec.x) - modvec.x/2.;
      p.y = fmod(p.y, modvec.y) - modvec.y/2.;
      p.z = fmod(p.z, modvec.z) - modvec.z/2.;


 //p *= sin(p*(sin(ptwo.x/20.)));
  //p *= sin(p*(sin(ptwo.y/20.)));
  p *= abs(sin(p*(sin(ptwo.y/20.)-2.)));

  float d = length(p)/ rad;

  d -= sin(p.x/4.)/1.2;

  //d-= dot(p,d);
   
  return d;
  }
 
 
 float RayMarch (float3 ro, float3 rd, float3 modvec, float rad){
 float dO = 0.;
//  float maxdist = 100.;
//  int maxsteps = 50;
//  float surfdist = .01;
 
   for (int i=0; i<maxsteps; i++){
     float3 p = ro + rd * dO;
     float dS = SphereDist(p, ro, rad, modvec);
     dO += dS;
     if(dO>maxdist || dS <surfdist) break;
   }
   return dO;
 }



void marcher_float (float3 campos, float3 rd, float2 uv, float3 modvec, float rad, float time, out float4 col, out float al){
    col = float4(0.,0.,0.,1.);
    al = 1.;

    //campos = float3(0.,0.,-9.);

    rd.y *= -1.;

    float3 camnorm = normalize(rd);

    uv.xy -= 0.5;

    rd = normalize(float3(uv.x - camnorm.x,uv.y - camnorm.y,1));

    float d = RayMarch(-campos + sin(time),rd, modvec, rad);

    float fog = 1-d/maxdist*2.;

    if (d < maxdist){

        col.rgb = 1.;
        col *= fog;
        
    }

    else {
        al = 0.;
        // col.rgb += 0.2;
        // col.r *= fmod(sin(d*3.),0.8);
        // col.g *= fmod(cos(d*20.),0.3);
        // col.b *= fmod(tan(d),0.3);

    }
    
}